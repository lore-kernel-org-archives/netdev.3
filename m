Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9546123B638
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 17:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787507289; cv=none; b=emyyy38S7U5xdz5oGNOevEsdjtfS+OT5KltASq0vtVoCHcQEwd1io0hS4ChRHgrnZZgi08XCcs1UhUTUgJbMYNYX7U8IfnN1kokwU28DuXwDrPJ43NUQpj1ppE7c6YAHL0HqxhOdhS9Vgpgfyu9N3iVqhprl/X7Fyr094iZ+jcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787507289; c=relaxed/simple;
	bh=x9a7F6Xn7AsPtGHNM278OAhW2duib729pbRTrTBj5xY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=se7g0/Aw/AWTTqjLdFNVDTwtorj65AVWOD5xcpMi9ZWvuyRVsbD/U7voa8pcRc95fyZkctFdRbK0YSVRSxSERdJ5zsJshD0o0GFJNeFzHzhv40O5XgSMl6y4wHeqgC6XTkkCSYVp/W483HDF6AmngHfzupEoinIw8SLzYGZT30U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGQljfqw; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGQljfqw"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-81f36179d72so43685857b3.2
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 10:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787507286; x=1788112086; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DuL2oALqrhJs4xUXx1njL4oc6NDgkUSb9N20AmGz1Wc=;
        b=UGQljfqwYP484H+gxzyQ41M0LafwT8n5enugGq/LVHYlQckwDKqfKAzNy6sRd4YkgW
         91HlGlgLmondK3aDGDUwndBm643BoGBbtHGYVVjbs20AszA49GBsEbpxGlAr7ofJA5vp
         WVx8aecLO5qulqyBm1IkSlzliD+5VogyvA94iN/7vCPxvAYSeN8V3W53dIkVSi5X9DTl
         kctOHDfbXkTZrV6kvEHWnChN9gSoH9T7oaiDf5IMGySKvQSBC4zVkNnytWw5iaeglpzY
         gbnSYF07fWFxO9Shady92xcIiNtzgoJiC0qQvnOtNCYAhDnlT2Ra34I3QBcvYOVMbb9R
         3FnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787507286; x=1788112086;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DuL2oALqrhJs4xUXx1njL4oc6NDgkUSb9N20AmGz1Wc=;
        b=MCf8YjpafarQR8IbDe4VSKe+REQ0uZD8cog665KmueFLQ1WyDKFATKOXH8EPkqVAnk
         nHdHAfijPkzz/yr/l+0BJgVledyn7VIzsTnLmAyxwH2MZadqG1fGN2DOq+DSbKggFecU
         BleQmWlh9cihzxqFVOn+c4waFXpE6PQIvf7zHec/WO7zpqQ2QVoKvHsh8OWF7b4cMy+b
         bYqokXf1byTEEhXbbZIHFKftG0Fr8rWUce/YAkCVJ78w+Ls47ex1BbB7o5JIMHVOGsMB
         EkBIkGeJIhtaQ+Hq6T/QjMi+ksU1Wc0+xMUHY8elaP3TgC89ULg0bWBar1/yp0cX264y
         GrMA==
X-Forwarded-Encrypted: i=1; AHgh+RooiIz2S72sg5rXBIi2Os8pjcRDwX8IQthqr4NaKQ8EQKnqpZUul2Dnhx/Iq/EyCCNKMliPF20=@vger.kernel.org
X-Gm-Message-State: AFuF++k3pGj9bmiGDjRravml5Z6KFsX9ISCcKXH1UqE2v12OaiCEfPkb
	LyDzPK6k75SNcY0O/jlhv0/TzzbrxAcHpy3VIwlpEpiaIyp3+MNnmtl/
X-Gm-Gg: AR+sD11q6b4TnJsh/1afLND1gNZqpcZCzpkkqwI/Q60WLmJ1FyHyUZ/53HmLbu0wYdl
	XyJAkekcZgiHpSDPlKty38gWI4qpMS4ruJiTojJ7zp1hP3mvyH9qxa5G0bROxXGfF8pAVSmnuBo
	hN6wotIsi0Ia5j7CV1SCQ6cH5NfXbuqczr0BfhiMt2/s3A6fzinrXmSDuyu+EhUcS+SBULaykI+
	iRpjknaPqdueCOz85pCRMB6kSoGd5x0K4r2kLBGCDg8txw62DitNbwHXGWTnOMySlXtVR/lSBFm
	plWNiB0t7v7VqBVlw14hLEJ5FgEiKqKSo9lFQv8iSmGd4sAnke3LRy1N0AxSvqEi9ayOmDMzt3H
	syLszaEPmM/Y5pkRunC7EIAbvFE+JpN5hB9aFemh0XukeyqmSdugns0g7alWA0Bfftb1pCPlgDm
	K4iCqdXx9HxZO2Z8egnncpe0uw5rls2lECM688EN9o1nGhTGuyKiXPiaZGH6M/CJr3ZCyMtk7n+
	o8AucJ22AKXiuKKQxq10oO7sHVxL8Knum9gIP0JkA==
X-Received: by 2002:a05:690c:7482:b0:826:8d7f:f498 with SMTP id 00721157ae682-84c936608a9mr54675927b3.2.1787507286405;
        Sun, 23 Aug 2026 10:48:06 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84cabd2861esm22501077b3.37.2026.08.23.10.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 10:48:05 -0700 (PDT)
Date: Sun, 23 Aug 2026 13:48:05 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 daniel.zahka@gmail.com, 
 willemdebruijn.kernel@gmail.com
Cc: edumazet@google.com, 
 cratiu@nvidia.com, 
 borisp@nvidia.com, 
 kuniyu@google.com, 
 netdev@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <willemdebruijn.kernel.1157fb673940e@gmail.com>
In-Reply-To: <20260822225524.2328465-1-kuba@kernel.org>
References: <20260822225524.2328465-1-kuba@kernel.org>
Subject: Re: [RFC net-next 0/6] psp: use virt cookie as Rx steering hint
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Hi!
> 
> This PoC series uses a field of the PSP header intended for tunnels
> to auto-steer Rx traffic. Various attempts have been made at trying
> to get Rx traffic to land close to the core where the application runs.
> By default RSS picks the Rx queue based on the flow hash.
> I'm not going to cover all previous solutions in detail but broadly
> - we have RFS in SW which looks on which CPU Tx happens and backlogs
> Rx packets there, it is quite efficient. aRFS is built on top
> of RFS but tries to program flows into the NIC. Some NICs have
> a "cache" and try to automatically remember the flow to queue
> association.
> 
> All those solutions are entirely local to the receiver.
> Ideally we would want the solution to look something like
> TCP timestamp option - we send an opaque cookie to the peer,
> and the peer echoes it back to us. Our NIC can steer based
> on that echoed cookie.

Another option is to reverse RSS entropy. This requires knowledge of
the RSS secret.

Especially with PSP, the outer UDP source port is defined as flow
hash, so can be used for this.

Have the receiver compute a 4-tuple hash such that it knows the RSS
block will select the intended queue. The only free variable here in
general is the source port. Then communicate this preferred source
port to the sender.

> This patch set implements exactly that using the optional PSP
> Virtualization Cookie field. The PSP standard doesn't have much
> to say about this field:
> 
>  Virtualization Cookie - 64b
>  An optional field, present if and only if V is set.
>  It may contain a Virtual Network Identifier (VNI) or other data,
>  as defined by the implementation.

If using the PSP option space, no need to (ab)use the VC:

"When the Hdr Ext Len is greater than 1, a Virtualization Cookie
and/or other header extension fields may be present.  The presence of
a Virtualization Cookie is determined by the state of the V bit.  For
example, given Hdr Ext Len of 3, when V bit is set, there is an 8B VC
after the IV, and another 8B extension header after the VC.  The
format of other header extension fields is determined by the
applications and is opaque to the PSP hardware. "

Right now all use besides VC is opaque to the device.

For use-cases that should be interoperable across vendors, we should
probably define a standard option space, with well defined options.

In a manner that is cheap to parse at high rate, so no arbitrary order
variable length headers.
