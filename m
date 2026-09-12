Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EA019E96D
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 00:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789174385; cv=none; b=eJAH4j0ungVYQG/U91DzH9K5pPqHlYQ8Mgwmxo4Dmi24a3FZRq083WopQMQrw4WECUOwCjG4EzU0l94VM4WUYUI2TC+sUg7KNkHWd92TfH3PGoVt9sbKHEGuLmI/VWHzO+m8wdJoXsMZ3BiwblPH4FUb5K8MqaNYtGiM4IDqVkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789174385; c=relaxed/simple;
	bh=Z0B1tYQoy2wwCjBSDJn+vaoAZbny+EqSWEL2H4Ek3mI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=aAb3B4VgoVbpEkJkBsc0Wpbnyle+k74xfk4ylkQ9dZ3k+JVNkjaXUWfgR51uSIIlPpEH/QKfvEfviOBMzE/syFjhKxxXFV92Wj/TKJQGInQ3i2TLGWuAjiioPWaVuuQ2NgD4Rpbuza4tf7GPZ6/0XceO+gqSlX8qLkiVzGR8FH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XrMGz679; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrMGz679"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-530e67fe8a8so2614271cf.0
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 17:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789174383; x=1789779183; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z0B1tYQoy2wwCjBSDJn+vaoAZbny+EqSWEL2H4Ek3mI=;
        b=XrMGz679areLNmPuKDMyhIna1IRQdnT2i57c4NbFNUez9HGoq9Fe6q6oAR0cQVuNjO
         MUG1WSeH3mgfHGmFgcMpW5J4Ka1TfyX2sXbAyq1z380IHkwGGc/82qSL3ZZpaoHZDPpD
         PyS+NaakHpWulEpcWsjbn4udShXkk+Nq1sHA7aQPXykMBM3302yH30II+A7Mbe0PbjQV
         HC2I1tZlbqhsE0Q/HdVRbMBH6z2G9fKK390PLyTJpJ4AItDAHya/2Ghgnxjlx/nOSxbf
         pw19KYQstMswWDAkIFZR7StG68JlQaP+2961xMuRlHxCrqDNoZ/686KpUFdu59fH+HzO
         WA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789174383; x=1789779183;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z0B1tYQoy2wwCjBSDJn+vaoAZbny+EqSWEL2H4Ek3mI=;
        b=Hi9HVDMiQmsPQQoypDPpLdk3A+HiDAX0k96oXIQRj6vVYUSafLZ0k9sC2s01xFQE5R
         vQQ0St4+2oiUQ900lqQ3S67mTMsw00uTC9xWfnf5bXYrcBd8sMFa6ttLxKZyGGnSibav
         m51GedV12q3VZTI7m1d+pe4poZwXqh+1A8gT9kbZrieFU5A7XdscOBFO07Eif5W82l4z
         R/Q2+8NI2NbPOEeFpypENs/E1tZUyIetydb7Ib9onGLM8vYbIKV07NDkm+GGTB2PiKvD
         oduPOQMoPY5m2TzBqqkRj/kH47DteMilOeD6JdPA/qmHSgh3eF3HALG7+k3fPIfiUSWZ
         wsWA==
X-Forwarded-Encrypted: i=1; AKwUvBzzwiTiHl4wEx6k5qtEZ2zY0lwX/b+r2RgKKbvMP184pzRinW6IDspJUFmVU66Oh4i7Sivg8Hs=@vger.kernel.org
X-Gm-Message-State: AFuF++m6Uddwj+VELVVCFuIapbG6D4g9cbmy2xeaYqQmWUuMPvN6MGEE
	dFMIbdA/2WV3lSQpUO/3zhisATizOfL3BXxlktbwCzYUoxhWkHRp6iUn
X-Gm-Gg: AYBFou1Q7PEcELVfa5zHDfhnuGchg8LTFDbkLFxxM1aniPf5y5nOzALhmRtYdICJSYo
	QIdDvaIcnsn/yU3+O0n+ToLTZrrBauNfVmxj/T0WUM2jJm/+XldgNeWVTf/ggHb8h/pOMgio1bp
	RfXN975J1VB96vXbD77g/yuH1I87EKn+WxYYwhQjni3adzLT0aJjgOjlQbzBW/bWH4reTijQ4Pt
	KA920lCjTjPlEdTBbvYcBqhdoUbwikjTlagZb9dX/ulD2w7gg/hd45z9QQEab1501knPuNvRi47
	Iz+G33zyyvhJ45Ar5PzsMoVneDlB4G1yPkINqW96eKCZp/cMGj2cn6xr09BiRDKWlb+FgUt0FyL
	aeaHAiWGruaLUz5O5IJhfVlkD1ys96/JB7VNeahJmsJulzomOcU8TRPysZlWJ/9kA4WqsPwxT9V
	pCvrYv1Selx8DH1FdDIWDnoPTyiX2mY49JIg5w1O/J1F3Yuqs26s4WyYw=
X-Received: by 2002:a05:622a:64c:b0:51b:efbb:fbf with SMTP id d75a77b69052e-530c8542899mr105004331cf.18.1789174383053;
        Fri, 11 Sep 2026 17:53:03 -0700 (PDT)
Received: from localhost ([2601:8c:4b7f:2b40::d060])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f478bf1sm33798776d6.25.2026.09.11.17.53.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 17:53:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Sep 2026 20:53:01 -0400
Message-Id: <DLCXDVPGGC8M.11EBKPBY2KNVP@gmail.com>
Cc: "Willem de Bruijn" <willemb@google.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net 1/2] net: psp: avoid conflicts with skb->decrypted
 and sk_validate_xmit_skb()
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Daniel Zahka" <daniel.zahka@gmail.com>, "Eric Dumazet"
 <edumazet@google.com>, "Neal Cardwell" <ncardwell@google.com>, "Kuniyuki
 Iwashima" <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, "Willem de Bruijn"
 <willemdebruijn.kernel@gmail.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "Shuah Khan" <shuah@kernel.org>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20260910-psp-ktls-fix-v1-0-e3f30aaeca4e@gmail.com>
 <20260910-psp-ktls-fix-v1-1-e3f30aaeca4e@gmail.com>
In-Reply-To: <20260910-psp-ktls-fix-v1-1-e3f30aaeca4e@gmail.com>

On Thu Sep 10, 2026 at 7:46 PM EDT, Daniel Zahka wrote:
> PSP conflicts with TLS ULP in its usage of both skb->decrypted and
> sk->sk_validate_xmit_skb(). Offloaded TLS conflicts on both sides in
> both Tx and Rx. SW TLS could mistake skb->decrypted in the Rx path set
> by a PSP device as being a decrypted TLS record.
>
> Prevent PSP from being used with other socket features that use
> skb->decrypted or sk->sk_validate_xmit_skb().
>
> For now, we include all TCP ULPs in the sk_has_decrypt_user() check,
> even though TLS is the only one that conflicts with PSP via the
> decrypted bit. This is intentional because PSP was not designed to be
> used with ULPs. It is best to close off surface area that may make bugs
> reachable, until someone wishes to design and test an actual user of PSP
> with ULPs.
>
> Fixes: 6b46ca260e22 ("net: psp: add socket security association code")
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> ---

sashiko and clashiko both point out that sk_clone() is still broken if
the listener socket has psp assoc tx state. In this case, the
sk->sk_validate_xmit_skb function is not cleared out in the cloned
socket.

In sashiko's eyes, this patch constitutes a regression, because before
the stale validate callback would mostly just be a waste of instructions
on the child socket, whereas after this commit the child, without psp
assoc state, would be ineligible for rx assoc.

I think we should remove the ability to attach psp assoc state to
listener sockets. I don't see a simple path towards making that a useful
feature given the current model we have for psp that is very much geared
towards upgrading from established state.

As a reference, Google's psp repo [1] demonstrates listening sockets
accepting a psp encrypted TCP SYN, and replying with an encrypted SYN
ACK. To make that work requires exchanging keys beforehand, and pre
installing the psp state per connection on the listening socket. That is
a completely different connection model.

[1]: https://github.com/google/psp/tree/linux-v5.15-psp-v1.0
