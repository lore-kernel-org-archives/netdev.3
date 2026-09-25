Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE4D49DBBA
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 13:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341342; cv=pass; b=qGI0UFKzTXnfCSCna3APh0fBEq8c1GQDOYzb6b6q/jLsNMtcCxefEE9nQbnYco2wtksgsKy0c/RQW2Q4zCKoC1E0cgdndtMWSs142N5wNdsvG+tmGxl3Jv4Lx6iZpgl19TqCO7OZAOLSs967BiypJgIeZS2xhQnfM/E0MxfNlQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341342; c=relaxed/simple;
	bh=lW/t0ljBqFMlE+2JM9CDRp5S00XDRA6MppSwwR8dKC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZlpEVIyKVoFgTRSmtG1LKdF3xtZNCUMR/62wqfxgQ5M4yBUAhwIhbOfn0kW1GRoludunkqaKtaAa7gFjdZiSuHUhbWtH5cwJ41TKpYyKALHa+hHzVlL6hc+uahWoAPNshU/0ys+SojKZ/VcMLDkF0445Sy5z8L0QkZTtrc1+uY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IrJieSNa; arc=pass smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrJieSNa"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c4bf3defecso672410b6e.3
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 06:02:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790341340; cv=none;
        d=google.com; s=arc-20260327;
        b=FIlzvysE0z6t1V37jNv5x2HTMu/IBSFCshNhOm/1Y/sorrjUiwKzyeZpFJ0orMtK3h
         QM9PNGTeNLvD5qhFfBfD91dk8zSk8Ruo5yYnsAq/19azusZr7qkdHaxpIuBq2LTg+JKe
         83MzMQJHWYa/JyuV2stzh5Hx1XJdZ866JFf7T0fHCUzP47kQe/Hgp1QquJ3mQ0Efm1lA
         D/41c5Qy16pliyb5ZcO3KrNGYn2xxSpXMpLoYwW7y0jys6jGUd76Yj09+Pha29jpAUuY
         ZvqHprcigLNFjNL5eN7mfnlGlTxTXvxNhFaYecgLxfnyumwDKbEuTWPb2EFDWxznFn4U
         93TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=66DuN/r1j06HGfAgzFt/xw2W868bH/m+NSU/xQtEkJk=;
        fh=OsYXKoY2sSKBhNTThW9kucESC7dyZwg253Kp+7pxyN4=;
        b=hiPXQmEEPhk6MCpa/tjjTD7c2BVtNvycEfIkUxdiRzVsa/gD0LQxwDVbJ6cKTEp/Aw
         DeeqnRyYuWeXGNkglN4an4vTOrU3LZi2gCoKk/TGe4buZ8wJG6wJe8WG//N3aQ7ycmt5
         Rmr/aA8OFRAgHaCMEf3qXIBqIkXoa77amf2D1/4esgU4yeNg1X7+m8KMruk+cPOpGmLl
         J6HwS4Yy4vy6QThYStUTsI1J6FcsvASHrKQhEeNwNGdffe1A4hmsUiA0D418/VCoevZz
         YW1QmdChv8BZ8YgUuPR3FrszXTvm3IA/t0BhE2YWwgICS1M3URsVkQzlvCkQJHDmlDQL
         4eNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790341340; x=1790946140; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=66DuN/r1j06HGfAgzFt/xw2W868bH/m+NSU/xQtEkJk=;
        b=IrJieSNaiXLIBo+8TwoMfBMARxFFC11HI3dr5jEeUNrzImsXG+6lJEBPUW610fzdwv
         yt4Qo4MmEv0AMF8Xavw52acMQlmhMFDyzUzC3TP69nVybivr61WgBxwhjTUaPDIleJK2
         UAjcyzXd7Nyq8ZHpfqOwIZjhhkM4QgLtcv0FMPtmcdbGKlnApIdIwSeXgtirsLOXdlHm
         wRkZE4blZqYsUnOPqexn185cIwa9FOBLJNjTd/3FBqkYwNQjYZBM8eH/i5ITK+C1S2fn
         7yhr1OFvqUR1IhmNyzDdCuBT5BTFfDhUU2qcKwsL23mcSc/UMZlIkuUA7pD+UvX0f+V2
         qQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790341340; x=1790946140;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=66DuN/r1j06HGfAgzFt/xw2W868bH/m+NSU/xQtEkJk=;
        b=L3ZQVMI9AlHNPmvN0GkkwdIfSMwi60H/bNP00g9s/a741aDd2hzTNXSZZx6Qhu4Cop
         ldl7FoLLlLoRkzhzWDtX4yRklfKIeFB/EzPqRzs4icPHO4V2A1tgZtXcHbI8/VcsilR5
         OQBnwtehqVZj9itBQpoCNigTWVGbBY+Qc8zWUHyOSBa1pW/zAKY6m2BV1RVt0znuGT88
         XJsDaoslW9I8MtCWge3jjkaGREw2OrgHNfLMCFRabCcLMKv6Y4TJ+3lWagIuuGGKy8Ei
         mcqsPErYQPY6dK9tYMYIo7E/o8krR8Xk2BYGj3ZVEQ45TksWXzIdD5Yfd6iNOqvDw2/5
         1m9g==
X-Gm-Message-State: AFuF++mlKXiABB5r2tp+VrRYItAheSl0wCMV8bG3cr8x7z+jXsoJeJ0B
	G+I4bQMelVGl6q1FLzcmcMBvipD8h+OrsTS8wgniQwdz+vdlPwrtwv6PN39mnkMnRO+QaduB8/J
	IKdWOWPcwodrrpicJ9rIlKsAcuwe5ZBw=
X-Gm-Gg: AYBFou0qMRqZbIdvgPirXUwxzIrOtorOQoLBEa5wISRLOPLctf+vDipRRHWOMKGrtQB
	oiqt9IO3P9kjIHm9FUG182i0hBL/v8BziGAQbZa3ZSu8Ls8syyy3pyCN4WyGJf8FoxuYbuLNehj
	XVtNLiveR/9YST/O1+pYtbbZ3g2xj1pwcQRCb8fAeD5AnqL5yJdphNUMjzmb2/yhv8DcFvyvTeS
	GTQG0WSZRj+5XSHztTT3GqqdZ62RgO0fWWDgM1nPAXiTOH8Gy5eVva7vHvZble9RvVEWahSS5Gn
	AgOYiN6Jm7x4NkS1CbNGsn033I4H22mSBb4oCGqFGLC8VIUYJvDPgcAg8UMTjIK3cDdrAmpu89o
	UaFCsZf1mIuhgaq1mapURZXJUZdT152NY9Bwxudw=
X-Received: by 2002:a05:6808:238e:b0:4d6:9153:2965 with SMTP id
 5614622812f47-4d72b63ec49mr5682940b6e.54.1790341339731; Fri, 25 Sep 2026
 06:02:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923021945.2203368-4-mmyangfl@gmail.com> <179030278530.2160803.5892691162510957034@kernel.org>
In-Reply-To: <179030278530.2160803.5892691162510957034@kernel.org>
From: David Yang <mmyangfl@gmail.com>
Date: Fri, 25 Sep 2026 21:01:42 +0800
X-Gm-Features: AclHuK_gINeSpMhsubRK169bx18RLVhA7P7kiUVoIOpcpYjxFcYk38Fd353bgFU
Message-ID: <CAAXyoMPvvmi4YV4BF=nWEchbd4SWtb2pmS2JVcsv=ro9SuuLUQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 3/8] net: dsa: motorcomm: Identify port type
 at runtime
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux@armlinux.org.uk, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 10:19=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wr=
ote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The commit message says "no behavior changes intended", but
>   the patch changes which registers are programmed on SerDes link-up and=
=E2=80=A6
> - [Low] yt921x_port_up() chooses the XMII register block using only
>   pp->serdes and never checks info->xmii_mask.

Slop - you cannot get xmii on serdes ports.
