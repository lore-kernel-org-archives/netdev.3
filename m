Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C6F3793B0
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 21:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792185934; cv=pass; b=HObopQZsneB6PFsAp9NYo7Hs38Dfk+i6U04zLNQ4WCdUkGOOLC27I0D5vu8tKKvT4oWpbmrlyMQSPRQQtXa1rqJFojgdnZ4f3lB3nERiEq4Jds8+mZOdNNoPJhUwESLN4dEYxtpIK1irNpmOsxJhM77ZVklKNaSJxpSlPKHEUqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792185934; c=relaxed/simple;
	bh=LElthuPsn/7TYpPq+R+k0wJNUaoxQUU4pHFLIVdSMGY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=C6kaqh5DZohZHcVyExvMwgBPB/z2nwyY4d5gSfmP7koy7bjoIHzxJ87QHAShG8GTGMqd9kSYmIqOgsWjvE49WYyVriWfBEb65DfYpY3aK+hcMrM11aH3ZwSxOlOrQKiXnou9FCcGF00fBXVMBySkDUZ5LWngAatkFt4K1PbYDkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XaL7zg7D; arc=pass smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaL7zg7D"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-917a4b69a79so4740086d6.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 14:25:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792185932; cv=none;
        d=google.com; s=arc-20260327;
        b=fiWBkf3FjKBRoGI2lOyfW3YQrNKa0P+5jpWVaTvnRFdN/a4OEXTmEwKl9BJJDc340k
         7HlFCP4HcEIZw/OTc0Ze6SE6k6MMoh1kbsrdpJydJUVmEc7i1JdVx8nLpbQ5L82sxlSJ
         jyk2nyQNoLPGzkBdbwQijGjIyWNNsbpGDONiDz+crjWthi/KsvYjK4liCLQXyzOVcSCS
         OSIaseLuPmR1dImjnHeNLgXMb3tmqC8r8y7Q7owiaIRzAOEyofDT6yH8Noti1/AmhVq1
         amdVFwUoZU0uCKoZ/wEEv9IfWYcsPnC9Dxf29wpLYDjeR4x556dcP4f/v+i6t0XrzwYz
         C4Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=8ayVjMNxSu57uj3PmVl8DsCWHmYuapevpS1NhYOtLbI=;
        fh=ewyel11ujbCy6l/tQDaGwc5bnkxKmVZ7JltiX+Nruw8=;
        b=aZchII3fgDpP4YP9Eh5n1ZEW7FlgBOyxcCVoy0udSarvOLqYPoY1mEGmf7sG/+X+Tg
         key4bfaegXLMdvDISo/LP3lefND0sg04hMpmj/G/Rs+XnMzG7Of6LDmL5O0TyvZuz7uR
         MUBmXNXzmadmwamnp3BKPsjEx3Eo7vC3wAuriEZZ47xnTv1O/qvXoyst71uOrfP1PqVU
         N5119YfeCkEdBho5kdy70hHM7B2MAoUP9P8fJ2TQTErK0DmC05KNiLMkr/5TW9Z6tzLd
         tyLPIDDPdMWa+qU3XWF0nYcjC+FK/ddy6YZUsQJ3n/xSFicifUSHE9Slbf6fVFaGWnon
         sP2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792185932; x=1792790732; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8ayVjMNxSu57uj3PmVl8DsCWHmYuapevpS1NhYOtLbI=;
        b=XaL7zg7D05k6usCMpYVTnFBwWsauW+rTCGVcmv35CynHYcx+G12WBS2hZVQ9GdTmyS
         ActjcyGnVDAeTGGYUv1m+9FzUZKfBYFQiosIL2P21jnAy8Tny8EPyFIvnSB7yK7geUpL
         nheDqrsR19qenJoKmI1lIcj6otzBGJ5ol5yjGgoadA4GDRrA/HvHK74m9Oen8GP8oPnO
         iiBDynWAhEJbpbxoHBxUDW26E3nPHTsYrjsitfgKEJGtFLQeGDj0A2UDDaNpEfGxFHX+
         IyPfeipB6zdznrUcsQgF4M4IEmfcCTUuTPvylV/0r4kJwQEYv0S2T2eMLQ+SIOf+QxL/
         yjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792185932; x=1792790732;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8ayVjMNxSu57uj3PmVl8DsCWHmYuapevpS1NhYOtLbI=;
        b=sed0vXyiNqRis5UFNJEqJNLaANAzPaycwGIIecO02MydaE08lY73zQ6muhvUSG48vE
         0xdToPKcV/kkS9IifX2tBnwi7IS453qtXGmGPWJK2wmmSUVDv8+v+3xgtDuceY1ck2eb
         6ptJB6Wyxz8zqoKsVzuplUpdy2tRblAKyVIIHxEJts07+lKRI47oCAjutl4ouc4A+Fz7
         VKMKrOu0IYKFiOGhQ3HlKatrZxEvcbFnCxr02zb2vn4lOHSfO8vL4HaCtmw5GKoSC2V3
         Vr7AUbOKZR02cEvpQVJxLAX90gZ9rvuKZhCc468dkaz74VRzIfLQGPD3A0+xgXBwe51A
         zrSA==
X-Gm-Message-State: AFq9FYK97D2iSGZCN3rSSLSqpbEhimpa0V0Fjs2klS6wdUNjMihX2EtC
	oZIwWhTuXEnKDu7LLK2KfQ4G7RlSNmCrI3OYZ7ritJOzoufPdbTCz1yvsMckJrGYXuNEz94pWmG
	dhmvsX6JTJM9rdDYyj2OVTMjznvRHZBHffa82
X-Gm-Gg: AYBFou29d+STAFSTPugDKkj5dYoJsizoM0G12eXIXl18NVJA9gbwW8VvaV1+DunBXVM
	YqM0U7QCJQfqyjEGDc6NTpRTceXuTlhrDennepBvf+c/D4Xc9L+FY/dUJ9kUYYH8/pOTNkPvEjK
	AC8w1SCpYdRkGg3iNq4IStS3vFsvKr9IyoOzQU4/9BuFd0PDsS3w4g4Wzdebm5/LN/OpGMafKVe
	+2Y0/oL5zQ96H1SFlHbGA6ieRbpTeucNJgryW4gHpAi5iXuqGZkod87FKdnMr988WC8n+8GBIma
	7ZKSEIx9zP0IKnbMqB88TvC7FlvChZDunAOO2lWCvXEgAmesqVh7
X-Received: by 2002:a05:6214:5f0f:b0:91b:8272:5157 with SMTP id
 6a1803df08f44-91bdec17542mr24685236d6.2.1792185932246; Fri, 16 Oct 2026
 14:25:32 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 16 Oct 2026 14:25:31 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 16 Oct 2026 14:25:31 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Megane Hebo <hebomegane@gmail.com>
Date: Fri, 16 Oct 2026 14:25:31 -0700
X-Gm-Features: AclHuK9pmWtEy3zQyyEKGrHhE1l95osK04juwr-0ujtfJxacEl_f2hsKY5beLWE
Message-ID: <CAJPVW+=TP73rBavAGTJVqXVN4Uer6JwOi210+2V8nDsH=H=BcQ@mail.gmail.com>
Subject: [PATCH net-next] virtio_net: validate csum_start before installing
 partial state
To: netdev@vger.kernel.org
Cc: virtualization@lists.linux.dev, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, xuanzhuo@linux.alibaba.com, 
	willemdebruijn.kernel@gmail.com, habte.yibelo@gmail.com
Content-Type: text/plain; charset="UTF-8"

__virtio_net_hdr_to_skb() currently installs untrusted NEEDS_CSUM
metadata into the skb with skb_partial_csum_set() and only then checks
that the resulting transport offset is beyond the minimum network
header length.

Validate the raw csum_start first. Successful packets are unchanged,
but malformed metadata is rejected before it can transition the skb to
CHECKSUM_PARTIAL state. This deliberately does not replace the broader
ingress validation being discussed for virtio checksum metadata; it only
narrows the state transition at the existing check.

Link: https://lore.kernel.org/netdev/20260922030310.8684-2-habte.yibelo@gmail.com/
Signed-off-by: tonegawa <kiyotaka.tonegawa@gmail.com>
---
 include/linux/virtio_net.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index d6466f96cdd00c..c8180f1222f492 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -102,9 +102,9 @@ static inline int __virtio_net_hdr_to_skb(struct
sk_buff *skb,
 		if (!pskb_may_pull(skb, needed))
 			return -EINVAL;

-		if (!skb_partial_csum_set(skb, start, off))
+		if (start < nh_min_len)
 			return -EINVAL;
-		if (skb_transport_offset(skb) < nh_min_len)
+		if (!skb_partial_csum_set(skb, start, off))
 			return -EINVAL;

 		nh_min_len = skb_transport_offset(skb);
--
2.51.0
