Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F37448D864
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 19:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792351491; cv=none; b=CQXcoTHiCpC19HeuLKGuq1EJU7rbXNd+BVKSuXL6abnxg20g/TUzJi7mr1WCJiC6I8lmapQxnPGoOUzbmZ94ikwLkmSakVcAr9oU+Zwi1npAYSZ64tSSNEZNcJ6q2bH9wD7WM5c4KYYEyBGDeqAoAeHwhqgVy4vrwFgpk2pC9kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792351491; c=relaxed/simple;
	bh=YuTSyzPwXKhPhZHoKxzOloJV3Vz1FrQSyVr0HWn8gug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhw3ruAm829h/lH61QPEupqnG6UumE/RJOXJCGnVD0swY5IiMZYhQzBz7A/r1SHRjj5lBVcBltXaMNqkTaKZJ4yrN6pC7F7KoGjrndusqEcG55Q5ATQdjmtN7nRnfvUqEchR7DAwoT+omRZ8/g6LzPVEgC34XvPffF+VpKIYlIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bjHlBlGJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qp7GhmKQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bjHlBlGJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qp7GhmKQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792351488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kZevltrwKAvYM+Logu2umHQbFiDiJJvS6eiPwGpSCUY=;
	b=bjHlBlGJ6Insd1axqjskG2D/fPEqF33Ka+8iwxPH5UolAo3h1rgnydFRWLhshpcNqEuHa+
	A8GUzWYnM976fgXeQ/QKIPOvavrg6WCSise+y058FlGFpMEwsUFaP1+SEIouAwqS2IH4Zv
	ploz9olgpsZv6HMg2IWWu1WiOlr6kOU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-1Jfyui5dOqW3vyCuBY2egg-1; Sun, 18 Oct 2026 19:24:46 +0000
X-MC-Unique: 1Jfyui5dOqW3vyCuBY2egg-1
X-Mimecast-MFC-AGG-ID: 1Jfyui5dOqW3vyCuBY2egg_1792351485
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48dfdc0fa95so846378f8f.3
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 12:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792351485; x=1792956285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kZevltrwKAvYM+Logu2umHQbFiDiJJvS6eiPwGpSCUY=;
        b=Qp7GhmKQEl0Qc301NULVc9LZpgMa3ADRPPESl15Bne+xmXFE3MFylBGfnRG460PoRj
         VhgPDsFzFIQSkm/X55sngrs2e4Kl8ZbPkopIKmEZLg5F/woq+Eg5n9P4V/3Jn1KI9Vpx
         CYffU2441vBQreS8sUX5YDCa+MPbgDzoKFDhz3WSdw4Q6UyytqiQNwVUXWG8O4ltDHAN
         9rKoty0odW1fmS52sf3pexJTGBtJUJQF9GYbqyANkkyVXyzH8z2wa6ycMep4lJFt0e/F
         8ipTzmhkflyPLMF3K6xTA6ttskbRojhgpdUjVZ/G16TjJ2OTu6PkhCX4e28GF8KqHFfC
         o5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792351485; x=1792956285;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kZevltrwKAvYM+Logu2umHQbFiDiJJvS6eiPwGpSCUY=;
        b=Dw59ZV5eIEVLIII9sOaFpZHPxx1Rxmvjs9qPh092ZZjMGwRJbWk/+/U84JppU349Cv
         PwtIbjypJaxS2rIFrmrrooAddjr5PLnqooEud9eSnHT77EVqExBoJFFakz1wPX7a5p6o
         B5GXI3Vj4mBFAAlYdZn5oIGHStgZHYgDMbkTZidmdQhiUMy+tQSbYBBi+Pss5qTUuBrL
         qpGGhe+Q7CNTyNiNfTmvjBmmymYMOnUDx6hki3PEU87W7VcZCFKG+4utg9bZYKf+EA66
         J9XLcJEI8tQ3K20uoZXjysEDgq7ACtnz8VJ3Au5OHJEjoYRjUfH03UOiViaMNXsqplYt
         hWPg==
X-Forwarded-Encrypted: i=1; AKwUvByydg6n1diRCgDf2ZK51yOopxp/6toz5TQcDTgzG/im6sOCGSQXPRB2VR9EhWnfQ9bwv4O8OOI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKxJycwO9AU9mN8feZdcIzISg4FtLy4WOV/9HDdLusDbnGzszyX
	jLKHRgwxU1TVB5jR2Dj5WmynhrpZ0eXaiH7m1IAZ+6uZWA4ThxCkgU1Oo9ZNEvzqcspL7l6YGXU
	B2EJylviV/a48sZFb7lTNvSgmEDo4uWXTN4NFhwjk6froXK0PLGebVpJ0AA==
X-Gm-Gg: AYBFou14dDOd6GMQaDurdBl1ll4CxVlbSOhepouSVDXwcdi0/hkoQrQbsRqORFfDAjk
	rR69QwcntBsqZJ8G41r5j0BWCNtB9e49EZBFpAXthOo2eKn2JYIWYnLQqQMrKks5yrIO0BXulT3
	jan8hLTwkNnjhjUgKh6fdGTj/+vJoZVVnQBAFziBDWPPpY6dE+OoF8wrb22rY0wbRb4ae6dyDrc
	aRwVZyg0e/yWcXKQP705Dah2sGwqP4hfpLQh3Ub/leO3PyxdEbS5/zGQJE5vCuDI7LXHxc0ThvO
	2Zs93Q9r2VXuGSQ9jiyrSBIc/wB2n/w7K7/wRs2ghfOOiw5yO7NluzHASX6AZKnfzSp5ZQ==
X-Received: by 2002:a05:600c:859a:b0:4a1:d8c5:b23f with SMTP id 5b1f17b1804b1-4a1d8c5bb82mr91473555e9.24.1792351485139;
        Sun, 18 Oct 2026 12:24:45 -0700 (PDT)
X-Received: by 2002:a05:600c:859a:b0:4a1:d8c5:b23f with SMTP id 5b1f17b1804b1-4a1d8c5bb82mr91473295e9.24.1792351484626;
        Sun, 18 Oct 2026 12:24:44 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1d30d778bsm207005645e9.9.2026.10.18.12.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 12:24:43 -0700 (PDT)
Date: Sun, 18 Oct 2026 15:24:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Haoran Wang <haoranwangsec@gmail.com>
Cc: jasowangio@gmail.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	eperezma@redhat.com, linux-kernel@vger.kernel.org,
	security@kernel.org
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
Message-ID: <20261018152358-mutt-send-email-mst@kernel.org>
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com>

On Thu, Oct 15, 2026 at 03:23:45PM +0800, Haoran Wang wrote:
> I'd like to report an issue in drivers/vhost/vringh.c:1216 (function
> getu16_iotlb), found via static analysis of Linux 7.0.11 and verified
> against the 7.2.10 source tree. I have reproduced the leak on an
> unmodified 7.2.10 kernel.


This should fix it I think? Can you confirm pls?

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/vringh.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 9066f9f12ba1..4b097170bd36 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -1213,7 +1213,11 @@ static inline int getu16_iotlb(const struct vringh *vrh,
 		return ret;
 
 	if (vrh->use_va) {
-		ret = __get_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
+		__virtio16 __user *uaddr = ivec.iov.iovec[0].iov_base;
+
+		if (!access_ok(uaddr, sizeof(*p)))
+			return -EFAULT;
+		ret = __get_user(tmp, uaddr);
 		if (ret)
 			return ret;
 	} else {
@@ -1251,7 +1255,11 @@ static inline int putu16_iotlb(const struct vringh *vrh,
 	tmp = cpu_to_vringh16(vrh, val);
 
 	if (vrh->use_va) {
-		ret = __put_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
+		__virtio16 __user *uaddr = ivec.iov.iovec[0].iov_base;
+
+		if (!access_ok(uaddr, sizeof(*p)))
+			return -EFAULT;
+		ret = __put_user(tmp, uaddr);
 		if (ret)
 			return ret;
 	} else {

