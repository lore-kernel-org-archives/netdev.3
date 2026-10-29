Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793297228;
	b=jc9gHr6L4kA5IaQL2aBt4/66mPouJjlAvX0Co8HTteoMD6uy0Qqb7luT4hG7kUqo1+vy
	 Fi/G6xBU2/n4VkOk82OidQAdCtU3Yaxsel+kbdZrHIzuPGSup6IiAdAIKfQGC0g2GXxdU
	 e2WJmf2sHhqsVTBPYxYCrjA6g5Tzgj2YnB5v3FfW+sjGits0nMqmHRZTL4WAFu7NxxcH7
	 MinsQJYdaqKtHcjRwOxzHMUrXLN4K7UPeDLslZY4hSbly908aUZn8vScsmGz2K2oz1QoR
	 ukaETYQUDNzk7NFdjblU/wnc/cvxgTAtOYg6e78rGBG945jZ9A3L3Ti3C6OhG17vviA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793297228;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Content-Type:MIME-Version:Content-Transfer-Encoding:From:
	 To:Cc:Subject:In-Reply-To:References:Date;
	bh=mdl2q7bYgyRiGGu1Nd8Y8m4pgXUNb+bUSGq/DaAvAic=;
	b=JUKgHCZaqPH0vVQABmQL6L2ZmD3rjyR0x4K8dDjzbqGHIWgmR/56Tj00xAgoqMn114fO
	 bAkhPszPK+DAtQXUob169ZJydG/VaebCfrANX8BWpQZ1FeY1tS8PRzZee152APrHnAbtT
	 qtLVLFNfMoIbcYtMTDZuAYPlnkwaRTe2SdrkjJgfjsVDIOtxD9JxMhuYsKu4qJn1R0ruk
	 YeK4MjTc7tcVtPWHYE02JklESEta2NZ0JvA6ThmsSZqMZGhZ9TaAyv6po5fPe6VgTfMSk
	 eierHwrabLYV2ERUG2x3J5WlyUB0+U1T8Hcd0Pmp9y6unfRV1blD6EAhBi4J/TgHucg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=goV3UiRS;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE28606A321
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 18:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CE28606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=goV3UiRS
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48e10a70540so1613808f8f.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 11:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793297226; x=1793902026; darn=vger.kernel.org;
        h=date:references:in-reply-to:subject:cc:to:from
         :content-transfer-encoding:mime-version:content-type:message-id:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mdl2q7bYgyRiGGu1Nd8Y8m4pgXUNb+bUSGq/DaAvAic=;
        b=goV3UiRS4/JqtjAof3nv5tvVThur+kPBovzAtGEKMeGx1UEQSTtN0qN2OFEUBwLjyN
         HWRXveU5R5DCDMVyK7w41sS1cnoVY5eG6ICY6dEGpeDNEgYaqsjNqBPk+deaWF3sP+BP
         ZIfjLXk+UCsSGxdEREF6LfVh96e2uOCYXYQNzBpZOLX8XfNdE2XnmrrT0g/tnm5SKxum
         Xmc5gDP0byL2hDY4INLLwNBTTyCVuYka3io7mCGu4xSVj/LHAsVCN6TR+w0UD16GqNfu
         JWbmEYmGh8fkvFH/OJlKDZs/lmPwZ4nJwcSyu1mfH57vb7hB8AspF9Dv0z/C8wLvRR06
         LQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793297226; x=1793902026;
        h=date:references:in-reply-to:subject:cc:to:from
         :content-transfer-encoding:mime-version:content-type:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mdl2q7bYgyRiGGu1Nd8Y8m4pgXUNb+bUSGq/DaAvAic=;
        b=V9RVzKYH7d0xPh1bJNKkXbyiMLxvxWqTUN84jOP1Mf553ZAPkP+hLT53fekwCHz9jH
         zbMbINLE7pukSRgmGYbw20ejpHT/aLb/L5alFCSC1HLMewVJO6oCFWtuoic23MQmFBVf
         a5Q8ZRuUC1JXtGOTRxrX0CpOGrewFpGBGqK9431CfUq1gMscFdvC3StyQ8zeRnBjpS7Z
         kOpet0SPKS8PmKJ9ifDaqaV+z/+/46/t8ZDWGrd7vXIEmV+bqz34ckaFbpWCJFtUkPy3
         vS7gwjkENLTsSLR1QUyWjhuSQ1w+L7H0v5eJXzVf3WMECGMPxBianngGNKYaz2F2fwjx
         0Amg==
X-Forwarded-Encrypted: i=1; AKwUvBxKjsO6ntISSxceDNp+p12VPzg+IA3xMxIzR+NeTlFbCJvcE6biG0MjgU+ZWLtpRPS9pfJFeHM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLeeD22Vy8NC04nhMxgQtd8Zn0odW2r0lBslgZy8nKX1LnunyIC
	2FbLJQkK1qyK9/BCJDyGAeptxTCrwP14DUlFs+PTK9cQ7UdMZI0tWuk=
X-Gm-Gg: AYBFou3yRabA20f3L10YmsCxGZra7/i1U/h+tbgTYFy5qbTg2CmfsaGSOl196COUIlB
	ZwkTKaz08yqKnTMZ15O3371zSNbTlRiGao20RaSF5eBuQTZYr7cAmXd1BItI/KSMie3GXcJG5Zs
	UHVP2vbLdMaZqROpJa/9C4ICIrtX3Hq9u5cxRWDGk1V6vp5t4wVkZvHGcc2YcC47Nyer6HtcxFp
	TIJAkVH7psPqTo5nKj9vyv4wJNQRYmFD3oFwEcvckM/MS7EYPBEjESqBrN5fsX5/dUldghyZ8R+
	Uvsu4OSrJBFpUvpMolQd2hTmC3/XoQZS3dQQFFJIdIH4SmxtGfTjlCk/KITJdq8hUr0aHYYZqde
	4EKtlkf261Qzga7sOCHu5PCm/xBuzvrrpoXwkPUR38KOishWGmf8iKZFROM47x5vUxPe//sTJMX
	3QMPY0T0YueL5qztsI8tExHdfMsI5x5oxqrc/Y6ODm120jCxqFXI1zuBt3MpsOVr7Y33lT4jST/
	8hmm9hqmH+mIe+RGGFiU7Q653DdqWT1pnsih/iWOE+8f6lbyGiMMdoS4SfY93Husc96Juy/5/CC
	nA==
X-Received: by 2002:a05:6000:26c8:b0:48b:677:f80d with SMTP id ffacd0b85a97d-48e6e2ff7demr405585f8f.26.1793297225850;
        Thu, 29 Oct 2026 11:07:05 -0700 (PDT)
Received: from [127.0.1.1] ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e6eb8bc12sm9433f8f.34.2026.10.29.11.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:07:04 -0700 (PDT)
Message-ID: <6ae38b48.a6a2e554.2bec60.2370@mx.google.com>
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Tristan Madani <tristmd@gmail.com>
To: netdev-bot+sinfo@kernel.org
Cc: David Heidelberg <david@ixit.cz>, David S. Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 John W. Linville <linville@tuxdriver.com>,
 Samuel Ortiz <sameo@linux.intel.com>, oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH v2 net] nfc: llcp: use disable_work_sync and
 timer_shutdown_sync in local_cleanup
In-Reply-To: <179329133392.3327.1911358623600296609@kernel.org>
References: <179329133392.3327.1911358623600296609@kernel.org>
Date: Thu, 29 Oct 2026 18:07:03 +0000

VGhlIGlzc3VlIHdhcyBmb3VuZCBieSBtYW51YWwgY29kZSBpbnNwZWN0aW9uIG9mIHRoZSBORkMg
TExDUCB0ZWFyZG93bgpwYXRoIGluIGxvY2FsX2NsZWFudXAoKS4gY2FuY2VsX3dvcmtfc3luYygp
IGRvZXMgbm90IHByZXZlbnQgdGhlIHdvcmsKZnJvbSBiZWluZyByZS1xdWV1ZWQsIGFuZCB0aW1l
cl9kZWxldGVfc3luYygpIGRvZXMgbm90IHByZXZlbnQgdGhlIHRpbWVyCmZyb20gYmVpbmcgcmUt
YXJtZWQgLS0gYm90aCBjYW4gcmFjZSB3aXRoIGFuIGluY29taW5nIExMQ1AgZnJhbWUgdGhhdApz
Y2hlZHVsZXMgdGhlbSBhZ2FpbiBhZnRlciBjYW5jZWxsYXRpb24uCgpUaGUgaXNzdWUgaXMgdGhl
b3JldGljYWwgKGZvdW5kIGJ5IGNvZGUgcmV2aWV3LCBub3QgdHJpZ2dlcmVkKSwgYnV0IHRoZQpy
YWNlIHdpbmRvdyBpcyByZWFsOiBhbnkgTExDUCBmcmFtZSBhcnJpdmluZyBiZXR3ZWVuIHRoZSBj
YW5jZWwvZGVsZXRlCmNhbGxzIGFuZCBrZnJlZShsb2NhbCkgY2FuIHJlLXF1ZXVlIHRoZSB3b3Jr
IG9yIHJlLWFybSB0aGUgdGltZXIsCmxlYWRpbmcgdG8gdGhlIGNhbGxiYWNrIHJ1bm5pbmcgYWZ0
ZXIgdGhlIGxvY2FsIHN0cnVjdHVyZSBpcyBmcmVlZC4K
