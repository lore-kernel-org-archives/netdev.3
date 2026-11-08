Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794174125;
	b=HBFpXwTHpvrrK2R5uH0J+SMCGv0Gq9xL7VuPDwkjbQErGouSDhYNNBoGLWf/epHQGxYE
	 1UgVjft0yTihgO3jFz9XhI2HKHgsgHsZOBrpyKmNcBru08D1ONm3coNXqP7F2vJuyLNSo
	 ur0E2Xvh+Q2D8Yj9Xr8DOCwAWNVAWds2qy4QyFIWCQLoUpYkhaVf58SozqEY0S/pxBAT/
	 8Wo2cPDicN1bLKbJ3w5bCBaPmOOK8I8YjhSXpVcVf1TqJ82Fbffc67FvmwRRQajFB3CMy
	 mXehlUBdpdt9J2ze52XAZVtoYaS3/FRW3cXXXMnvllDCK5t82gjPw+QZyRZHk7E7fqg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794174125;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=t/DRObdlnu1WX/m6QMNEH/t/PMgtKhUilCwH55NBFgI=;
	b=xnw2djSFmIha+fh8SWOLVA2Gv0Z1mMVrpVuEcIHvEsoNYAMWp9RtCbMCNnEGPLqGNh6I
	 S+GvQTenYG0A/0HEq+wZMLQ9MQHh7vXLUSI/ATd6qUEK/HaYqmZsYH3hP1gOhHPtHaIri
	 rq5rMYG66XQ4+h4ye/cK06j2JGKb3fzyRIpasQU3DLz28EAyyJXeJWR+DTfSEh283b7pO
	 62lEXJjivQSyEnzn4kD39IQVRre/Bb7mxSGRYZrucDuaIAVRMpx/z+TeaTVE/6ozHKPmn
	 Hk+JSzsD2SuTcY3G/mN5QK+umLsXhO4uM0Nt34mSQJJvXjp+efCtCjpHgvBAaTgb4NA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gjGujz+G;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67B5606A31C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 21:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D67B5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gjGujz+G
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b167ffd132so478082a12.1
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 13:42:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794174123; cv=none;
        d=google.com; s=arc-20260327;
        b=ZJ6B1lTOPBGVBtZh3ZTTsEDtgh/IfYSi0Dfj2nbgb04uXhchfqA3MqVg9z9IwBn3BH
         W9ehD4GUIVTAiI24CmoljZ3f3X+C0+arQnOFuVibyBANJjO9k5I3KZtqMAkAeIESWuzN
         UqdtkXjRP2+pEvdpPColeVqY7OpACO/XBwluea/gSVRLpiIqSioSeNmlJtPrxTXFgzt3
         B4hyNbZqHp/L9DABnjkoyz5fePZXADNQb/5moyGxRL2q/EXV7EVzqSgSRorKY45GB7a0
         oatGGpjodJ/LoxY3G8FoLGaH0EqxedRMrREoRF/WP83JYaz9R9Zlu2GonXkcZXQnU1be
         KZzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=t/DRObdlnu1WX/m6QMNEH/t/PMgtKhUilCwH55NBFgI=;
        fh=aDUZZ9N6NPmO6DMPx8G1ADwl9DVnQFUvUJ2oivftvxg=;
        b=kUSNlv1uRwYtirj2eUlJhTD8d+Xk3/yIPoNP+ipPRibvDrndNqPuox5EFrNqcK2Qr3
         elU/eELiJ/WN+k0gW1+ijjMKHV1/GuHaVHHy9bsxWCbMTJ/FPvOapBVuLRpqgMaUFVT6
         tmpmkQngrKTd+hDR1GX0GKnKaeiTZeQv/hHymkE073e76lIIGKQ/x4lmEGDWwQl5UiTv
         3ChATIl+pwwEYe1IMcFWmyoQ2QgXHTobZ/Z4zCLOrJlD2nXeza+4es5uJhnryc9smCLH
         4mhVf4+hGn32Ry+tNimc4cSL7H128WOKcNMiMZu7aYXTTqXjQtKBJapsRXg22h4U4TxU
         y0wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794174123; x=1794778923; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=t/DRObdlnu1WX/m6QMNEH/t/PMgtKhUilCwH55NBFgI=;
        b=gjGujz+Gg/c55PRfd/yq/tgVWsWKFjEaWSsOM8yRvYyNnI+KNZK7h/pC1hRyv0qk0p
         qsRoSjMdmaFi0yWj3ILF+YVoMw0E5rRD+upZgBmwh+VMMTaytnty0aO1Pw/v1I5S1Sak
         x/Onf7VgOT5xwhCcWCTNdFRVcs0OG4XjC8qzK3ircOkcOSwLSLGkaKdEEBRTHu40yjG5
         lZHu+q2EjnpUxQ9k+UnpQHcP6Q0jlATDkjaQST6HW6CKW68D8Wvj1mk/iTCqZgoGb7tV
         +5f+FyaVZ7Uf6i6Zvo1BbaPRxBEc0K68ldarb81xfql+GPxsP57Nib0SmmodB/HVNsii
         EDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794174123; x=1794778923;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t/DRObdlnu1WX/m6QMNEH/t/PMgtKhUilCwH55NBFgI=;
        b=D90J9Y4e6CAD7Dqo9VhWIUSmUoPLfYvfUDGkLkX4cpzGYEQJ5JCSfJRtZD3GxxJaZU
         OdAiiprdGREkTvDQcOvh93X+ymKd7Uc37WPvkaQX8TxGSUG8RdWEaZ8Lb4uev1OLY0pv
         k/sfEsp6cy21ofCpsKc2mEs+vSuYsiE1J0Nc3yK8AbD+sD6qM0ynUkyKBMatPAyVo1ks
         9Rn9TqdfOXczzHubAt1ATzLGpiEfsxGJl8YOL73wuvcC1673bSfx7XWoa5oJlWqR8Y6D
         qFV0A7A/QSm7tvn8OQlucAsJgUAcztYKWV1qOwYUY8pbZlgauPYNZ5v8ZEI/ypViywsl
         8FbA==
X-Gm-Message-State: APuU4Z8860xf36++i7mqtwnc1H72VAtsQxONd67nLXy/YkgiAvSZ0aue
	kSskcyydJm25GZQWhKTwI51CLWDY1/TPdbAg2HnPTNnP3ZY+uy0dYEAwiY+01mxtvHIrmVAk6uU
	R4TaI+/b8RmKp0ZTIxi9Zy+aI575niwgUoia0fM4=
X-Gm-Gg: AYBFou0XZTh8lB08EpzN3a7oW1Fbl2CetJT+XsycMXXKhmmOuoq4WP5NI4yfGbFfPzm
	1NgQF6ZaQ9IC6qrF3uJHHnbAgWCD5jrRRapvwfUorN7/Mx4rKEE+2nsixxBqp3+PZq4KFU911Ep
	w2yIqYQT2Tsy/erAE7jX0cyFbYwykpNoc9FbWNq8TTMumYh1FjpisUwhvriWpOVTkaBOmHdQvHX
	0LkwwD6k1hwJi7YiJvrXztCq+EuP4rwXYMFc0x8IZxJ7wdLlg+7xUgSa2GuUojZnm8O6Xm+pPsj
	MCQQhDNaIX0q7vqRJqD9rLYgKTyQ0wesYfkwX1dYCbdee0PhZGMddgTnJLqPjm7I5yXGD5gIN4F
	wIa69s3u6LJaCHzELh6qL/zeiHWdqz6Qk/cLrSDM=
X-Received: by 2002:a05:6402:388e:b0:6b5:8c80:d12d with SMTP id
 4fb4d7f45d1cf-6b722483e24mr1205136a12.37.1794174123158; Sun, 08 Nov 2026
 13:42:03 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: RZ Z <zrzluck99@gmail.com>
Date: Mon, 9 Nov 2026 05:41:51 +0800
X-Gm-Features: AclHuK_pIRd090NpcaI1AUn9MCYmsUWFhs2Q0lMdmtDCxiPv_hru6RX7ZnSqsTg
Message-ID: <CAGjTmwaxHE2acYOoDsCJGSmmfBdHm35Dc2EM5RCXX9+9R+6vdw@mail.gmail.com>
Subject: [TCP] Severe CUBIC single-flow throughput degradation over a WAN path
 with Linux 6.8
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I've been investigating a TCP throughput issue on a VPS running Ubuntu
6.8.0-31-generic.

With CUBIC, a single TCP connection only achieves around 3-6 Mbps,
while four parallel CUBIC connections reach approximately 192-204 Mbps
combined. Switching to BBR brings single-flow throughput up to around
200 Mbps.

I first noticed this while using Xray (VLESS + REALITY), but
reproduced the slowdown with plain iperf3, so the issue doesn't appear
to be specific to Xray.

The tests were in the VPS-to-client direction, with the VPS acting as
the TCP sender.

Here are the main results:

CUBIC, 1 flow:    ~3-6 Mbps
CUBIC, 4 flows:   ~192-204 Mbps aggregate
BBR, 1 flow:      ~200 Mbps

One CUBIC run achieved 4.25 Mbps with 107 retransmissions. I also
observed cwnd values around 2-9 segments under CUBIC, compared with
around 539-666 under BBR in separate high-throughput tests.

The VPS configuration:

Kernel:           6.8.0-31-generic (Ubuntu)
iperf3:           3.16
Default CC:       bbr (changed from cubic)
Available CC:     reno cubic bbr
Egress qdisc:     pfifo_fast (enp1s0)
TCP ECN:          2
TCP SACK:         1
TCP timestamps:   1

After switching to BBR, I also checked TCP statistics and noticed
considerable reordering-related activity.

For example, one long-lived TCP connection reported:

rtt:          83.675 ms
cwnd:         8
retrans:      0/29
reordering:   114
reord_seen:   428246
rcv_ooopack:  94147

These statistics came from a different connection, not the original
iperf3 test, so I'm not sure whether the reordering activity is
related to the throughput issue.

I also encountered a similar problem on another server with a
different configuration and an entirely independent client network.
Switching to BBR helped there too, although I haven't collected
equivalent plain-TCP iperf3 results from that setup.

Could packet reordering or TCP loss recovery explain why CUBIC
performs so poorly here? I'm also wondering whether any relevant
changes have been made since Linux 6.8.

I understand that CUBIC can be sensitive to packet loss, but the
difference between single-flow CUBIC and both parallel CUBIC and
single-flow BBR seems unusually large.

Any suggestions on what to investigate next would be appreciated.

Thanks!
