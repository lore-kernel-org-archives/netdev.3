Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0660340682C
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 23:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791242221; cv=pass; b=ta3y5kedQp196oDk34ZCgSot3RSyvrkFuNyfIMUVv1jT0+hL2CyCLPwjHCGwrbI3nWcKOhQFaN1jwuXZ1PXkXRgB10NCoJAXt2CD7La8wQ7qENbSyXU4++vmrr7aKRh7HurNu0AdZEqMIUmytcgRJJUOE2omh6fuhpWxq+DJURk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791242221; c=relaxed/simple;
	bh=za9hu1YYVovCuUdIpWVDTK3e5USASw6UFL3szK/D1qE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jU9sJFNVaoMnjJ7WxG+/eFoFk5Mp4twStS2L3tmhVa11698ejgqqdtGr97p6But2vvkcBCjLNMxH6yE5thUJeB3sD84HId7NVhNKhibe7+tBM7Uz8lWq5lmRXc6oMrIwhYPu7RnGVH1sNyYwUS9zGiknFjpc81FSCGAAEzt0UG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSC7b4VY; arc=pass smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSC7b4VY"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6acb91ecaccso3608822a12.2
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 16:16:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791242218; cv=none;
        d=google.com; s=arc-20260327;
        b=px4SPL/EBUQ3782/xLEe5fNHFdWyQNcvWu746gbtKfK4h5TcabTIheold7kZ7IptVy
         T5NQTkDcb+OdlkyAP/DOuk2k6BZcQf+X8QMGmY0lxumjE8NATlHXTBoM2BclZbtsQf/e
         P6gFOJOMq2gdvtByFQKmsVt3incKF6PaiRPKJLOXKbTNijJ2VwmY4FXf+Lcp5rPk/nb+
         CH6jqZ8zcTeurUmmM1lpd720fvTmhgL62ijXU/zycHwKQzeBc97WgzdiDQyWnMuDlYQj
         LttH4ei6ed1vXYig8ll4hh7ZYTeOw4HCLWsRfLLNRn/kl+bSPRqo62SJamiL0FoMe5ay
         K2Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ggl0IbFeEE6Or0Q3w+SXUyGJmoXHMIUd48S2FNEyG24=;
        fh=eGA2bSOerVHAkvo1l0zipwMttWrtxiBrwTDkGnpX/v8=;
        b=QdkrL98pejp54KAiQcP6kMJBG1gteT23CD1jRjsg0XpwayBcdIwaryAfcqYSwD4HkI
         VmuueG5T2hLftk7EFDH4ocYOFiEA9CAvP4x1l5j0Vb4xuZc8cAcMKWbmI+33gIahjphF
         VwuFmfBkgvfmw5BvaUVzGVVdpSSxWinDcMUZ3eiVXCkvpzLdsbaYcZl0tYr57TBe4OMS
         SjVUAf6b2U7DVuticdvY1onSH3LPr3QybYD+nSIIcG5/QpVxnwWBv2kwu4D4awxvvxEy
         1DT+vXi7Du9H9F/nlzVAVeo8CLMVU2gUNAPmt1JufgxgE96UdfNYQmRlX/QNwhREUxcZ
         dmGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791242218; x=1791847018; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ggl0IbFeEE6Or0Q3w+SXUyGJmoXHMIUd48S2FNEyG24=;
        b=RSC7b4VYFohQA+22vFEq/w3COkgVUnGQ9SwB9fX5ky4yNhxMujGkmLnfZKhegPM4fK
         6cab6JYPpDs7xxVoEomGeUVi4VaXF5X9wogyNmWX2jMmZ3zG14r1mMuNQda9v2KtQS5n
         pKUfDplw8KFaVSibZ4FnhjOeVw1a0kGmBSvoGTXtvMSfsPwJtp0lUqETNekHSQ2fHX/Y
         gzH98xOQmm/E3P8EMnocX9XKDUonCXiX7Jgr3Rl0ViUw4zBrIlMQ5l5EcuVXYZNz8Spy
         giOdqfFStOIj9pOV3mQWvg2NrwtBw4BOmuuh+I5AxHbt5RzGLQKhnmKsFWElEsmZeSed
         U59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791242218; x=1791847018;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ggl0IbFeEE6Or0Q3w+SXUyGJmoXHMIUd48S2FNEyG24=;
        b=M/TOpR0928DcFWrbzb6SVEw8f7zH0XwNz7fLeR4o5LCoX6yy175C/0VdqDQ/ZrfG7p
         JrLz8MGuy1vZPdl0uYVuMVARDqccu+jup6qJluxKvPPrTK0PnJzqmeIXcLspnDBvGjAB
         28l6iDYVBZvThUhsgsVitLhsBVVZwf7NZrNP4pCsksrb23E021ko9yCKh8VCCuTpjPYL
         kKxYrudkzSA66f33j0Po2wxIV3b0eapPJR+RSGVXZJrl/R1WgeFiWKhoLmZpKkU37PGF
         Mfhde4Y0+7w713gvC2nFixTgr2sa6r3O6aCLxXzCEYA+SANzaK351kQzbPkaoI4hHA7l
         SbmQ==
X-Gm-Message-State: AFq9FYLobo1zeruh8rB1TmKhrBsws11M1RVZYK+RcOhoKf0+zmgFViOz
	KPNYNROPsVtiQI8gynMhO0rnG/YuWewGZzBDR1pRaAIpprqaQ3d0a5a/jznZDokse3wex6cgOWC
	hbuzquXAjBX4wZos1hDvf3vmzdx2gEDk=
X-Gm-Gg: AYBFou1u1UJEyZE0qR3gSbPO7/AAN12p3DKtyOWAJPy7q7Ey1RdD1bCpQvIxXiEkR1u
	TZakzScUIFDV+WFi1OGBGb8XNoiSJeBxLsuPBU+Q1vtPjlpuQC9r4XuSQa0uXM51A8DbIjCjdIW
	MgTeA69T+BRjqfWBS3poyqXBPcYho9VcjZ5nuX1dlAQCvbst7cOFvy0ukl6Yug09aN7SYeZtvpS
	IpSMQb4EIZscouW+D+wLrI8SxQtZ6/0P0GtewVEpu6ShEgWyaFCTX6eRKvA1ELyhMW0xe9Yjq8L
	iZB7LCIDxgyILi3gvAHniJ7/OYNMJ48qY4IMPff5LwhQK6E0AJRFt4qkMMqJ4r5p3zLHKHpDh4y
	Qz/vM5gZ8m1t20deb2RuiVY0hUgNekDi0T5OICDBh7WQ3zWd6/pdQfXHwj4unn4Z0n2kYIYhR0B
	M+qfDuAjInjMbDDxM6EcvKQ88XndG4FNzS2FqeKnZpDf+mKUARME8EOp54IEDxyzy12bDPoml+D
	gIW
X-Received: by 2002:a05:6402:23c9:b0:6aa:ff76:3076 with SMTP id
 4fb4d7f45d1cf-6af9e356e84mr9525001a12.32.1791242217990; Mon, 05 Oct 2026
 16:16:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005225028.465866-1-rosenp@gmail.com> <179124091720.2231598.15531231594364757004@kernel.org>
In-Reply-To: <179124091720.2231598.15531231594364757004@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 5 Oct 2026 16:16:46 -0700
X-Gm-Features: AclHuK_s9Eud8-TCUpDZfMQzzNEAVfdhAdJIVWcNPPNRW014EWQvbIbsbgBlhm8
Message-ID: <CAKxU2N-POZFgujAAELRjvoT0N5AEF4mg=GzZvtQah2iQuhp5cQ@mail.gmail.com>
Subject: Re: [PATCH v3] net: phy: marvell: keep WOL_EIE across interrupt reconfiguration
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Michael Stapelberg <michael@stapelberg.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 3:55=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
This was tested on a Marvell Helios 4 device.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
