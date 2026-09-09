Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A4538C2C0
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788975184; cv=pass; b=BD81swOU80sWylMeWCXZ53XFrOP98OzN7WsjXn6xgMBDla9BT8NEm21ioeV72ANZUUJBSPc0uZV4fsKpz1sIzT1DBLoDcsX65BRu/7QoIQypUm5gwujWDqo3u3rgBewB9YEr/J9vJRJqeLKa3onuTC+/t8NlLbQUezgiJJizcn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788975184; c=relaxed/simple;
	bh=re78z8VwnjJVx6PndmI2PAAf2TcgSUlQDvgcNiuRZrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pNG1WE/nWKE20aGMtrQQm9hOX1vOeUfbBWzMEZqoKk558NtiGY0SLk4dxZpnHDxzXn8EgdJ+SCSDkmMqZQArhpxjNnrmQ5MWwSH+hoCUwsL8tJXnB1HhRIRXHSLywJVlQFcDQ4IR/VQUb+DS31JG9RqRuExFf38cLMOU5MPbJUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADG6rdp8; arc=pass smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADG6rdp8"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6be4202867aso683445eaf.1
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 10:33:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788975182; cv=none;
        d=google.com; s=arc-20260327;
        b=PxdIavDwftTY+x28A6B1n6jkK7Y3KaDn6JqGwebnZoBtWEJMXAZdan/oCrclP/Tgzi
         JWY863jcLIt+ZanQnbzwZKz3L5E9eLbp67EiNSg6QTxjpJZWVr7/iCDJlPUq+/4YxpZn
         mlwBX65qSyUTe9VxmfyuF5cwwoU9Uvbkm0bmQHsPyhv4iyrCtjwZ5dETYuaQyIw9bOGz
         aAwR1hAFUx//mxZWbuXlV05pLMpUYuqKkQcCboWfAeuHMV5wERRUYiuJlHuH2Zyfgguq
         0pm9Y9Pqb660Wa1FXv+9b3ohp8yEC19PQt0DVZYvXHu1St4STx5o4PcLXvVkmGFDzjLs
         a9GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9a7q+yhTyBJfb/NQ297CJoBt9orarrovB+ksRg7mIgU=;
        fh=OsYXKoY2sSKBhNTThW9kucESC7dyZwg253Kp+7pxyN4=;
        b=N1d5sz9eMvgljDEFEHslBpn6/arLVTumjNP6qlGalLN9gUj4D/rcGp45yoSC0yoURk
         EU0DhvXXGOZ6qK8ZCZpV+V/2Q6K70sNQw3koKupdj1JgKakLjn6eesAwxuSJsBr31k4V
         JMGDF1SJ//XmoBP8mcX2P6iCdhTenapTTfx85Ml/VIrDYe4A8nuNJZbLlmaU9d1jh1nD
         TXXWjQAgyfYrgBDaF5HKaeGy0D75I3yoltCjdconqXNia/riDTbWgVr1yYPWTyrI0W1A
         kFqXhzE62wHrjB1L0IzzNOu2b+Fdm0LFhIUcPt2wq5JUEOcYP2F7dCTWpuuRme0GHHMe
         qYMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788975182; x=1789579982; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9a7q+yhTyBJfb/NQ297CJoBt9orarrovB+ksRg7mIgU=;
        b=ADG6rdp8GtsFBUcgn/wTSJaeqeeI0PMoTvWlO92gN9zccB5KvqB0puRKk/hy4sq0cY
         0vVju9h3vj8bXlxOaVIOWy2Rhtl5dSCRhaTaLOlIOCIsWLWnAgTpCUyQXaceZFC0tBma
         1EwTMkN6Jj2Lb58VSuD2OujV7K/LS2s0SOANRYlmdFqyOjJMt/mvnMPx0ke8MK919JgG
         cEOE9suznYw7tEttKH/uzz+E+ci+QenpBerq8wM2NFhLa6vAGCj4e9FtmWQFbUwcY5vS
         K3ENyXVV8Q02KpWY+7Krfd/x6ZAUqvU8Ak1tdWByaB1DrBDh/4MQp3a+IwPMI8Q6RBxh
         XYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788975182; x=1789579982;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9a7q+yhTyBJfb/NQ297CJoBt9orarrovB+ksRg7mIgU=;
        b=GuRu9eqTTkTa9YwiVzrBhebowW1FNvmxt4fkDwI89J5jt7vdsF1aMmXCjFUBsnkaP6
         +7RhnBEboo1B9ERccVMb8cJ9jc0ULi6BejtnM2sYe7zcgeUciGVtzY7yUuFW5lI+6uzw
         E/T8XM/YsAxek2HAbk8umdxs9m6Mc19YwpgofZyLVrJ3nVRFqELjOhkEey5k/Yl8VbEh
         Lflpvnp4XLZc3caDFAyTXmGk/cHNQLD8LIp8iaJSRilq7rIXvdMVIiAAZsHr0eUgCPYD
         q7RFz2vSMCa4l6npW/xFfx41o2MwPa1IL1gv8Vqp3IbYdKxh0j17hhkU40HKMBlA58FS
         iSHQ==
X-Gm-Message-State: AFuF++nMaypbRmvZrImgUBLe1oEwayoxi7Sg20D6NSiYXOs7uCQ5v1xV
	tu6+1rSTfjokeDB1uio32TtxDDyNNQ+ozoT+V7mm4G4ehdwMUO8HtW1tDkCYKHMbco/1Hvl1BAu
	7nUXjgvsNdSfFUM5g2afumg4RtT+MuXM=
X-Gm-Gg: AYBFou2ix8JGd29+DNUw+Xs12pgo393Sq3fQA4hlFh7D2/ck9vcxDBbnSLD7qYGxKEI
	YIlHef/dvxDqNrvMnbZEBPEMUMbokVi+hXuaCg/RXrrZ8XhYnhlQKpYi654Fa9rmh3r9jErFA/D
	YUrXfVXO5RSItRzkv0PhXQoAkyFP3sS1s1+BObAB+MMGnWBGhsyzSHa6QYrY9SFvs0jrnfZtZ2e
	WQ+LgLudf4R0ig2AHwEiSFKS29XQbT9Ma9L1caDyeCMFyCnu3fmcv82ylnhCEBDncXb6IvjEofS
	AA6d22A1Aj6Y0ckPcxvhl7pbAazWMdLCvpMDNCryU2h2SzHXq6RxjCBtuhUNkeDMdIBdjtSQMn/
	dZ6HO7JVrYrNc
X-Received: by 2002:a4a:ee1a:0:b0:6b7:8415:d78d with SMTP id
 006d021491bc7-6b78415d867mr18306497eaf.56.1788975181984; Wed, 09 Sep 2026
 10:33:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260906131414.2683362-2-mmyangfl@gmail.com> <178896697251.219967.12696740711142321048@kernel.org>
In-Reply-To: <178896697251.219967.12696740711142321048@kernel.org>
From: David Yang <mmyangfl@gmail.com>
Date: Thu, 10 Sep 2026 01:32:22 +0800
X-Gm-Features: AcwNN1W1AmptlyO1-mcwo-J90MQOa1tlXZ-QA5t7ssmOONEuEN1r8iczultO9bA
Message-ID: <CAAXyoMNMU-Ly8o0uvpk=d0WKvJ0o8hsN-5NqfGfu4fB=pmVttA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/6] net: dsa: motorcomm: Rename MIB stuffs
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux@armlinux.org.uk, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 11:16=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
> [Severity: Low]
> Should the comment above yt921x_mib_descs[] in chip.c be renamed too?  It
> still points at the old type name:
>
> drivers/net/dsa/motorcomm/chip.c
>         /* Must agree with yt921x_mib
>          *
>          * Unstructured fields (name !=3D NULL) will appear in get_ethtoo=
l_stats(),
>          * ...
>          */
>         static const struct yt921x_mib_desc yt921x_mib_descs[] =3D {
>
> After this commit there is no struct yt921x_mib left in the tree, so the
> comment names a type that no longer exists.

Will fix them in the next version, please do not merge it.
