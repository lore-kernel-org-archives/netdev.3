Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EF950AC0E
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 17:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788542561; cv=pass; b=WrFjJhQv8d3z9BqkeVJXtmQR/up7cND2vwid3JUGX5c+Xo5xYCZMXXmDQ//hAo9TYoz1PftReFUHsSSPi9QPPGfy5uWCQ9Xo7G0nxmIcVWv0rlUWQLotumnv4n7OaC8ofHOoViQ2qoLMJU6o4SVppmRbVWE88iGiwNZR8hPXjM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788542561; c=relaxed/simple;
	bh=FJCnDoW1BsF8zLtfaO8qyAHOBTB/66qfCSUM4FGl+MA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hH0Sl6atMefiBgbnrX3OgzoNhqT79adcE2DOyTRc9IROI/KadZgyPvSQLAD04lGWI7m8mzZtEdsJ02XfZL4xqeWBzbH/w4LR6llmfRjRLmASGqELY//KkcaKBNhGk3yACFDu7fgsyavUgH00V1cpffOGF3rwhny//jJ+0woJFMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSJ0ASQ8; arc=pass smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSJ0ASQ8"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7f4e1568932so1117348a34.2
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 10:22:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788542558; cv=none;
        d=google.com; s=arc-20260327;
        b=liTRE/52PbXRs3jOl4pvEhgl6iklXe5oyuq6uItD2queL6H7MZ3rMK02fK9eH6eOla
         IAlmoDXaOzkaKK8IuzOUtRpAByv7IcFE2wmcaMLWCIlcGNVMyHL6V4Gt3mIhp9ny/TNR
         ktfT35ONoaWxKdrFaPSKCLkKT9GQsuzw049+/po8JFPmRdJlmjm1R8DrvA3tmcPvSeMC
         GU4sEKKgSAAKq+CoTwr4ycwqi+5jKdlFuUynofxJ4S8fMM9Bz8FVGyjBhdAF3u6wCNm8
         7Bi0jRGfYtzpLqLqkOs7nEhgMchcEP0UIgboRNs7sn5T3JYfw/KvDk2+XmjcTgVoVX4G
         rHQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5bQTn6eojEI+XPkavz13nbqJS9x7u4UcheihLwSIrXo=;
        fh=SLMfkV+a0OwRdCDZiGVrm4OOXhCmBnki7vbJ5DUcx7Q=;
        b=Wj2QnB6oPIdxO8pUpNgLCOmU/eIErOreaqscBlYan9WhSeSccOTvyOdUYNqP+VG/9d
         t1LM62Aqrg8qpPHwQbz6m/+vGFhzps9xxBaLfcNMj8jF2xJ/I4KkeASXPb+7OlnVpnW7
         VpOfg4HzdjcKfSqKIAQYMxMoX7KnryjLJN0VMhs1u85UHw3/Plyk7XBxp0m1Cz9TvcXB
         dS6V6fYy8gNuvW7eGVjn5ouol4OOIvVHeStRx9DZCHkStwXo6uyWOo5OZwpjhJzo7dFy
         MyJcBE7qVQn+z9DyHRppqRAHBag5dZCqI20oDoY6FLQr/BESIWMkYyt48XCGIC3gPTSq
         MOZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788542558; x=1789147358; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5bQTn6eojEI+XPkavz13nbqJS9x7u4UcheihLwSIrXo=;
        b=ZSJ0ASQ8a2TiRwBPPsXRSyqm1ORDCqe/47NNO8HZKp+CJ7AM2fT+ZBo9yjj+xRLUUh
         3pZ0N2ig3u7sauERjjiHqFcHIN+a7BrmaEKbmMYk04GUiAC2nmZwFaLDomZ4c+lOUive
         6DlSzcLkBpYdwNrRIi71O+bdxZlD3TIVIaUE6vVVd0I78PsIW55XG2Vyi01LMuddvC7B
         oMNHa4QkD75Ozih98qobSIdKJf8oKxAxvtYd35UbWXS3w/EP3N2ViHyOn2GuO4lKWGYY
         1r8tN1Rpkzo6/SUnoLkumskFjbnKopVS32lcxvHujbqA6THsyUxrya8vPyvMvbXBr+6/
         loeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788542558; x=1789147358;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5bQTn6eojEI+XPkavz13nbqJS9x7u4UcheihLwSIrXo=;
        b=EImFLiWHAy0IWT+dRnT8BnIzJYsIL+Lbl4UwCvowbNRsR9cysNmQ8ExCwy/QYC0NlE
         6II779lu1/6Wl+5FYK1GvmkPgmSUYPpJTVe+6aT4Sb4zM0Ft+dFgmUJoaZGNy7abJzpz
         hrG2L9OYglTbyFtB6PX0HpMHe+4DdriZk0yHrGC6PMfn3qkBZJ2hGvHE/oWQmtA4KPYJ
         N7Pt2d9WRrxbIASICL3kRKgsGYM1aY8VT669Gc50bMnto7pkRQGdDeN0YJ8opRLkKL1I
         npoUukVtKD+2ZZCPLiLiKlCmixFcCQ2jm3oR5HqvO63DYzjWovh2a4CxAAhPOYUo87Rs
         t4Kg==
X-Forwarded-Encrypted: i=1; AKwUvByXyb4GLEJZlSEClCENxql/75nOgsKfWnpVe/Nu93PV9IVBBdA+bpwYwbUdkeOD+HDnSxrvhO0=@vger.kernel.org
X-Gm-Message-State: AFuF++koyqaFbUda39/NykKPABNrkCKWu4Y78VJcKMs7+19GdYkWPgp3
	oUncUJ7gm5Gs0A+lieAxrgXxs4nZSceRNPP4W0L5LHIdGdfTPb7MPQWa+l/qMi0a55eZDK2fXaD
	Hd7d1hSk4sp+mH5VAh8MbOmfoBJVYeaY=
X-Gm-Gg: AYBFou2KVUsMP1vUMXUqmvwI98f74P4GQNMLZl2US4oXIjFzUxJ9EidXVyAYrelyuW9
	kTtU588YasT0IcRtccqzexxFbIiYQBa7RAg4WpYjWT8Th4vBQEGTSwUBmQ94HPP1ZUphqUbjyTw
	xVPlpGThAYQ6FQPNVRYwq8nRJ7R8WAPq7WokPTGPN/Ogi0ioJTxQgSnSC8dzFIlYzmct3dISEUs
	V88W1f1eEDc+002kQwDSHR31mxlDyNXPKHPfP0G7vj/eujCDEBjrHQpoDIxclv8+BDJtk7YKTnq
	ELnDVHx3RcT1I6bKDAdCjdnpaGfd8m7SvurqEppAi10eyR8DmKVltJQUW1h5N9qX6szmsdHUN9x
	vtg==
X-Received: by 2002:a05:6820:1c8d:b0:6b1:7141:75f3 with SMTP id
 006d021491bc7-6b6fb6d1f8dmr7009469eaf.13.1788542558254; Fri, 04 Sep 2026
 10:22:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904095416.1692962-1-kyle.switch@motor-comm.com> <20260904095416.1692962-5-kyle.switch@motor-comm.com>
In-Reply-To: <20260904095416.1692962-5-kyle.switch@motor-comm.com>
From: David Yang <mmyangfl@gmail.com>
Date: Sat, 5 Sep 2026 01:22:01 +0800
X-Gm-Features: AcwNN1WnzPi-GinWsR17e2jCghNlMfLLS0mk9JqF4ZQp-UwNmrrvJ4t1A-7W84U
Message-ID: <CAAXyoMO49pCWivneGxwejafDXnosT=v8hnE8q0d9qvyBm915TQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 5/6] net: dsa: tag_922x: add support for
 Motorcomm YT922x tags
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com, 
	jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 5:54=E2=80=AFPM Kyle Switch <kyle.switch@motor-comm.=
com> wrote:
> +       tag[0] =3D htons(ETH_P_YT921X);
> +       if (dp->index !=3D 0) {
> +               /* Port index is not equal 0 in tag[1] */
> +               ctrl =3D YT922X_TAG_PRIO(skb->priority) | YT922X_TAG_FORC=
E_DST |
> +                       YT922X_TAG_PORTS(dsa_xmit_port_mask(skb, netdev))=
;
> +               tag[1] =3D htons(ctrl);
> +               tag[2] =3D 0;
> +       } else {
> +               /* Port 0 in bit15 in tag[2] */
> +               ctrl =3D YT922X_TAG_PRIO(skb->priority) | YT922X_TAG_FORC=
E_DST;
> +               tag[1] =3D htons(ctrl);
> +               ctrl =3D YT922X_TAG_PORTMASK_0;
> +               tag[2] =3D htons(ctrl);
> +       }

This does not seem correct, as dsa_xmit_port_mask() may return a port
combination, including port 0 and non-0 ports.
