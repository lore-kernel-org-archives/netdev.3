Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53AD47F2E1
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 17:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787246144; cv=pass; b=KlCcGpEeYb/4FYPQBhWScebrKT8ptTC096/cz6o2qcYoNs9AgIbH8nUldIWmqFbj9Xc8woJ/f/MkP37MOI+VDFPzP6au6iItuEcazM8cNfgVEYLTnJv7KegWvgBI9rGr+ofg5E+dIjLHxPHHyTDznIkgsKmqPzXixjkDiCvqK4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787246144; c=relaxed/simple;
	bh=3c721Up4XKT9nSGpOXXtxDHVpHlRP7Uy92JTc+lNdns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MNBnn2VWUpphj6gVp3imvmUZcWYVvaweuTaMx3Ja5fmZWGqklEaIfLtS2cOCF6qWQTySkGf++eDm/GKgwDiJU9VhlJ9OotWpNzzIGFqxv2SgglHI1xZYQUFRWHbHmgfDHeBMMRuN59ri2NQl5p8rW5G/oSmT0NynhUPLGHDpnlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhlFp3TR; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhlFp3TR"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5b01cb18515so64897e87.2
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 10:15:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787246139; cv=none;
        d=google.com; s=arc-20260327;
        b=ovUt66JlHxgtceWVG3vRjEOej6Wz8nGLZcVHOD2vusNA7b4tgfIFmp0MVRH2iAhuEP
         6klVRytwSWZrsY4gk0G2OqeJW23KjVzFf+u2QXt/gR2xn0I0gg8/Pldgysv8eH/2P2yo
         9tStW3IIenyr3MkJ+9x+9eR/SJTHhcZcLotxaR1I3IqidkMzqnx8ydS4memVFzpnUe4p
         HzqHZaySEl3pbnQH2pTw920nmbGTZvE4rlvrDVvm1snVzasZ65lomqw9JdnZVUVzwwCX
         xFZuLJ5xgJ7XIy82brCLdVDwdTxYnaxo9Xck4cMDsWTVp4NobZKMeRexYuVLuGZthXxI
         zQKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3c721Up4XKT9nSGpOXXtxDHVpHlRP7Uy92JTc+lNdns=;
        fh=1uHUFJC9A0b0PJrXSiu5aJp/GLDnr7zj28CZ96VDHAk=;
        b=UOXPQjSqAoKFSLIlXXQEjJYEuo7RM09Rpgipy5Diwh6LDvQY24zYjdgLcCgZFKvlUX
         bjJU6REXvmhdsDul2kNtdFRbF/QnlNgjW5lvMPFxXNhJc4f3bUeb9mEF4Hdqi9Y/+cIw
         okNlIXHZEMhHTNrpzNwKjGUyK8r/bMFLot39PGc0N0jB3hLRAkqknPDUAIuDGxvHTwsk
         QLExi1b2r0kEbw+oymTk4WXD9BilSbqfKXXw9QyDbu1HeymGMIJVCofjiZQFtGyvzi8t
         VnpR7XqMNdxb20ejfgC01Ht5RwVlIZU10AMzhk9nV0Yl9tQSMJP+mzk6xJV408/wfCXC
         b+vA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787246139; x=1787850939; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3c721Up4XKT9nSGpOXXtxDHVpHlRP7Uy92JTc+lNdns=;
        b=QhlFp3TRefwrLZ5PfMTwM44EhPA7eyKSTgpKlbnn8CsBNAd+6s3hZS463nASuDpHC+
         AJxWvHeeK6gWkaANJOs1Li8zVYb/fJ8LAPNBJW6zoGBncjp3YZXPBeXJl02D4JiR/9hO
         ycHMAUkbsmDiOuee7uP63wrTV/iaI3TE1pEV6msMexdgEaU4uA9feVoFm8Z1cHGdsp1y
         wZNhRoJLmizaB/068ODHC4Udt1Ai20xGeK0V3yREl9YlobBc5n9g5JWd29Zgycu8I7sl
         6CBZuH9NWPt0QyEeG7aaAkiBQHc5bLdWkGYoE5bpXonU9GlrhZaAT8kRnfM5/ZCCmH2r
         xCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787246139; x=1787850939;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3c721Up4XKT9nSGpOXXtxDHVpHlRP7Uy92JTc+lNdns=;
        b=cl3ub4wpyev4uTZqmvp5xSZ7Ig18npT27E+nw88D6HugsdEGVdIej3l3qKuTKBIKTY
         t3Zbo6cb7Tv6UGtDmn+u0Vq7itsWP5QsfOWOb7ZhSvTfJ++nynqp5KCMwCH0GbFegTPX
         Gg2+Rev0EQxj6I5dp9CsLPG0ucGddHH15ynE9Qvi/tskJ5fiNfEgBYfT1qE8p6ZY3Vts
         g2H1syPV4PiZlG/5jTeMVxjqGQ0uJzYx7S7zSBKAlY6iy28UZJs5mrgG9ags9RtLuDp8
         hOyKU2r3B4MiDy0E2IhNvWPm6vlAADmgB6odkRxIIvWI300O7XeaK5rDG7QApidW/sUQ
         R6BA==
X-Gm-Message-State: AFuF++kbmQFgKerUEC4ZnJwEq1SDgyDN4NuDTyUKRupIJQG3wnhefeIh
	o/XE0nGJxZ5s0lRiGzRvit5cCiHDc01yUQOgoX3of+7Y+Ryd6KLGICIHqkGLmZPjupBhYTLbPB4
	y2ehBkFKgnOKkYVMTn7Pi3C52TaZV0/M=
X-Gm-Gg: AR+sD12Iv6AtIPHaQCWhBo7/3WV7E+rYjChfA0M0NyVW0wJbh5lph6yagHKAUTMu/ad
	3vG7zg/h3qnaX/sdYbKew549Cs3yS94gXIJWTySJps5Jasjh+tS/CBSDl0ZX5cvbq5OMqt+NOzS
	DFSotZqW45ZrGx3l9NnRWgLTMS/Z8GnE254VIqTYjlThNwE6i2I+4F4aqc+6n91XDLU5ipotn4I
	iKxeO5XIfKM+YsPjAf6LAb6zGWjHdOaIH3YXZqPDKrplNNb5iIBZ4+Is2onkWZZUzCvjR8YI+ZB
	l1BT4EDIcKNAvQhBJgcwqQ9R+gb7A8JO2AurB//Gd1S5RIvI33mlTkxj3scu8G6JOzrdybnkeiI
	aqSd80iSr9u6vElgA41/9H61c7w==
X-Received: by 2002:a05:6512:3c92:b0:5b0:bc3:dc11 with SMTP id
 2adb3069b0e04-5b478d1f07fmr4752522e87.22.1787246139023; Thu, 20 Aug 2026
 10:15:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786746757.git.ahmadexp@gmail.com> <20260818095654.5357db1d@kernel.org>
 <CAOQiBWM57ZBafMcj9MaegHBuM21313O5PqAAGXdHfvmHxHp48g@mail.gmail.com> <20260820100302.1609c979@kernel.org>
In-Reply-To: <20260820100302.1609c979@kernel.org>
From: Ahmad Byagowi <ahmadexp@gmail.com>
Date: Thu, 20 Aug 2026 10:15:26 -0700
X-Gm-Features: AcwNN1VG-G40EWmCjL4DcV3v9ciEADsSL9chtIKAvcClckRaycXWK-AFTAquNos
Message-ID: <CAOQiBWPZg4xkZFsUm9g6XBYz+vixaKPaofdv1rvxGwufD3jm9Q@mail.gmail.com>
Subject: Re: [PATCH net-next v5 0/7] ptp: ocp: Add R4006 and V9 I2C peripheral support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Peter Rosin <peda@lysator.liu.se>, 
	Nam Tran <trannamatk@gmail.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Understood. I will split the series and send the IS32FL3207 binding
and driver through the LED tree, and the I2C mux changes through the
I2C tree. Once those prerequisites land, I will rebase and resend only
the ptp_ocp board-profile changes to net-next.

Thanks for the clarification.



On Thu, Aug 20, 2026 at 10:03=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Tue, 18 Aug 2026 11:12:35 -0700 Ahmad Byagowi wrote:
> > I should have stated this existing hardware and end-user use case
> > explicitly in the cover letter. I will add it to the next revision.
>
> You need to send the leds and i2c patches to relevant trees first.
> We won't take them via net-next.



--
73
With best wishes / Mit herzlichsten Gr=C3=BC=C3=9Fen
Ahmad Byagowi, Ph.D., Dr. Techn., P.Eng.
Phone: +1 (650) 924 6653

 Please consider the environment before printing this e-mail.
