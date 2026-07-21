Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDDB446072
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 09:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784626771; cv=none; b=K4nZ0JlSEap3N0ALCizq1uDO2qVJkWojONkQJkaMVTYc9p90YpUWnZ53OGc6zLpJ89QB6hXCbDrvS7mU5wpInEYbrOtRMfVGkhgYmS2oGwPbTY4bh4sejxmGfnHvRRsy1UMYuyWYV4nzgJzZeiwOsZC7XUM/5Eb4beducAW6+g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784626771; c=relaxed/simple;
	bh=0fKkYTPKt4uj7/HQZsbhDBUmJQ7QCPoCt63/3w+4Smo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aujcEYAZoEZCTEWC2r5uVsUGx7WYuyni8LyyxtWYqNZsEib53rHO8gpv3g0AHwuTgTDOpXOfW+jeOqV/PThxTVM8Pr8bD+PvehBwV3pulWvfY5gi4McxHVGAcXMPrTO6SifmwGq7/ZG+H6jt9wKesbEtuEC9n+NlsBpAqDddYcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xi5z3QbU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=d/FN8058; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xi5z3QbU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/FN8058"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784626768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XAJjmayMkDIrcR5bs1MtTfqWHt+0QcGmY2S/SVvwZf8=;
	b=Xi5z3QbUh/nxYHZ2vGibeH8vEylC+2sJfT0J0s+jZNYyuIqiIGdCTBM+xLQv36aVIxz0Qp
	mGQc1t9cdI5iVUuikfWoXGSOmM10LT8KrAQOYgOmH/uY0Znv5YTKTJKE28ImQ/Dr+nSk8j
	gF1kTJCdA8Sp8tBVcXAR6pnZmVX+2Sc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-pNNd2TJVMwCYDXnp8UtpZw-1; Tue, 21 Jul 2026 05:39:27 -0400
X-MC-Unique: pNNd2TJVMwCYDXnp8UtpZw-1
X-Mimecast-MFC-AGG-ID: pNNd2TJVMwCYDXnp8UtpZw_1784626766
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f2de3ba47so4564244f8f.1
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 02:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784626766; x=1785231566; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XAJjmayMkDIrcR5bs1MtTfqWHt+0QcGmY2S/SVvwZf8=;
        b=d/FN8058dMlrtMrQOsdYGXMwvbaP4Hc0TaQGhJTdpljw/OpGEb3yLQz+P/Q63lwiNl
         3l5dIJapzEEU31bQRJPhTWSDOlb46QN6TVSM0Iv50oIIuAq4m8m/UC+xbDol2d7KRv0+
         WWjxCeLlj1kz4XVNeVMHO2CrSSOjr0xdg75qJrikHZKSiOwZ/DnR6IlCmgbFmq9vUi6Q
         j8OU0+fwlL01TkHetqnhSWQq9kxae7xwSZ2vYf/j7ddAkCz8LHixwhJOWMwT0h4k5zt4
         PzI728Y80PwQulMiM0LdIYJabpw7ar3E7JCq+I4lO2cVdpDp3Xw9b+PzQvwmIvca/OYl
         u+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784626766; x=1785231566;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XAJjmayMkDIrcR5bs1MtTfqWHt+0QcGmY2S/SVvwZf8=;
        b=YmPiQiSFFEHMz7kj6+NZemRuUJpqL1fff3Mgd0e6H7G5BKzCnQItTG3hbKvSJ3Nbmv
         M4MbsPwDffp5JbBnLzIpJxC57CFyxIOTnI0/A6bymUHJGlo2IpGYswkw7vbozUHNckhs
         G61Hp8vTY3HjImjkkoVa7cBSydqx9xx7OYvZNc6yhgk6wGDUipwUcImbXbh1XLmC9b1/
         Qkxth6IeyzWAURVuzUaroCr1DRibdzPXTwmzpp0K2hvO9+iYtk1zFFjcUBAk/eCWGiX7
         f6YATtpsTc1matclkR83AgbjrD//7J6RB2G2fSU39ltltDM5vQ9TokXhPCvbdU8/6QcF
         HMVw==
X-Forwarded-Encrypted: i=1; AHgh+RqjxvJzrADQPMozFil/gCSNKFcu7tZBKjWoop8HzqJCGEFhjaa7hzrm2C8VawNg+MxNNMn7A4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ICGgyjTx2ljxgNLxv1Ui3o7b1c97VZpdvtRgecgfpv37Vb1P
	Z775cF79Ou1AXt/VfpKY/vho6TyJ5HrspHZw2rAeOnzhtEatSsI+EAqSyEsPH91VPNpi9te8nVU
	rf1cFDoVF9L4zd+zbm60zsYV03soN/4PVkyfiDfaXUAxDJsE3FthwOvfalQ==
X-Gm-Gg: AfdE7cn28I99ImDVpItojR6BqvGk7x43Dln8CE+X62C8EoGuBspZDJOzyfmJp7J7Dcg
	uVBCx4/AR7I3JQwNN4MD08LuZe2cLTKHYxY6bBQ7bFkCTuFxRJ0aaBg53hC7qt6SzjD/j/fJVKB
	l+F5FfXMl8wSpSV9PpIvDI2xSEmU+kLT9oUMdKLS/uv97oVaQPukyB7Lm4MAb/fkreIpnheLLG7
	UAMQG5KTvslQMS6UQnIl6ttKvHWn9IAQR+OGD8kbbFcx3rZr6Io1oABDAVU8PiEhCgu25vRWTph
	ko5bAFO5Pa4alFjSJUBkabBBhTPvqdE3+MVk4mlVX+FFFpmKU520Et3rpH0wJLRCNwQZDSUlaGp
	Lj5lv+8guouhIDYGpLmaWurn/kEh/qHe7RHOuue9KeVhR7x8eCynX4jc9t/KMtnxUZOAgqnbCeo
	EnWg==
X-Received: by 2002:a05:600c:524a:b0:495:641a:bd3f with SMTP id 5b1f17b1804b1-495641abe94mr56802995e9.13.1784626765915;
        Tue, 21 Jul 2026 02:39:25 -0700 (PDT)
X-Received: by 2002:a05:600c:524a:b0:495:641a:bd3f with SMTP id 5b1f17b1804b1-495641abe94mr56802645e9.13.1784626765523;
        Tue, 21 Jul 2026 02:39:25 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49563eee22esm85739045e9.1.2026.07.21.02.39.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 02:39:24 -0700 (PDT)
Message-ID: <1e76e0df-9b73-4e15-a117-4244aa3be9c6@redhat.com>
Date: Tue, 21 Jul 2026 11:39:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: skbuff: optimization of net_zcopy_get()
 call in pskb_carve helpers
To: Yun Lu <luyun_611@163.com>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, kerneljasonxing@gmail.com,
 kuniyu@google.com, willemdebruijn.kernel@gmail.com
Cc: mhal@rbox.co, bjorn@kernel.org, jiayuan.chen@linux.dev,
 netdev@vger.kernel.org
References: <20260708055454.9167-1-luyun_611@163.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260708055454.9167-1-luyun_611@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/8/26 7:54 AM, Yun Lu wrote:
> From: Yun Lu <luyun@kylinos.cn>
> 
> Commit 98d0912e9f84 ("net: skbuff: fix missing zerocopy reference in
> pskb_carve helpers") introduced two calls of net_zcopy_get(skb_zcopy(skb)).
> In fact, skb_zcopy() has already been executed once before. When calling
> net_zcopy_get(), skb_zcopy() always returns skb_uarg(skb), which results
> in adding some unnecessary instructions in skb_zcopy. 

I'm quite surprised the compiler can't generate the same binary with the
old code. blot-o-meter seams to agree with me.

I think that the consistency argument is enough here to justify the
patch, but it would have been better to double the above guess with some
actual measurement.

/P

