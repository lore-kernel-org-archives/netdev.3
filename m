Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D37378D70
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 09:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786183144; cv=none; b=rRXGzf6OjrM+NdSqjIXTwMRjPe0d0H3/EPZPYhYw2RtL8Cfgc32yW2Vn2Y8Rp744pghTNu6FwzYhYhSuIurEVAFOkoKo/3RIsreqE9+bTMocAXGZVN8P4ST1O7a8KI/AElkPUKHfB5cFaC0QtF8TYKc/PgJuFwoqA1RjNTLvgFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786183144; c=relaxed/simple;
	bh=W0eW/ZasrcB2H3LJL+03kv0ucwEjc0ZwxAGacASR04w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skVcrFloNx3IUhlJzDne5rB3AwHFJDwUMmD4oMXb1Uq8LUQZ86IZGF0EwN1AYB3/5ov0aa5FKhu3OW64XBgze19cJ3ShP0YiR9isNZC/BUydxQOPwg9GUAAsCLrV1jYg9FJgawjKAJFT1U/mIi6+KgwPiE8aUIFmpetXJLbnHr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=IbduS9jn; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="IbduS9jn"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49553515a8bso5139845e9.1
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 02:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1786183139; x=1786787939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hr4rNoSGp4NHIekFunzyCDZp2DX3uWJ4HIovEA2xeO4=;
        b=IbduS9jnB2UahRDtFzqXuVcSkf1SQSDTZ77nciPUlfptm3qzygluDCSQTBKEDvPzeq
         8k77tza2nOc+9xrHVicwmDQHirDKLznbzGF6HCD9Z3uoK9gKk2J1v3Km9eIeAJaxoqM3
         dEIUp/Vub+Vbp/H0Ir3zZtrVfOLuoEOWhwPhyEL9wEAcwEtKnLVkWc1ARNNxb3/B+SpK
         u/4D5tdCc2hU2FTWTMCfjl/GhKtYajTCooy0QuevtdQ0QVGwroJmTgNXdwymbm5VpNBv
         w9WRXk0ERb5Fypm8J0hgmO9E6CR/nsr0svpCMAMdh//ROUH6WXvEOMRlAk9zvNwDssVU
         X3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786183139; x=1786787939;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hr4rNoSGp4NHIekFunzyCDZp2DX3uWJ4HIovEA2xeO4=;
        b=bYNhdtyLy5srxTkTo0vhs0gMpzAhZ1fS0YMyHpGzGYgvwU/MhzFiSX+JHTx6Wz86jJ
         /WxUnSJKOVCwWvo7qtwnFTGaCO8OBO04tXSyPDtnd688uqH5V7JMZG1oezJg0cgmQaxS
         zi68xQPSoTDBdEVgftinQK9ukYRXWCb4aps9ucTGyoVarst1owW8TrSgipFfeeOSo4uq
         PvnFCAVi/uMBQ3+hkiMb+qkPbOysrpfz/DM79IyOUfFIIJ5MoMG7qV502E+b9WD8qTUH
         25Ga9TCpbDgoa8AXIZwQHhl80QRS5ZEndgtdK54fDfMx5FlAifwqlUvaiaaLR4lM2QZj
         78JQ==
X-Gm-Message-State: AOJu0YzPlfUyI7ppWFyDKdjCY0tozCXnFytNHjztrnCiUWMkWDb1yv8Q
	qWigz1csnSMAoMC45RfNGKgHNVty+W5q8P2hE8mc+OW+hZoYTU6VC4T6CiumcrXd95w=
X-Gm-Gg: AR+sD11MkHIavb5nyRD6fKYQqmiimHVOamPhy2KqyGxtifV/L9Ukg92fFyOkR5r9z3K
	SBrNZt6xgjFGA+akfc1/xceAMtOmCMEGp2qaWRJVUC6ngRQBI9Lj6tLPbmpYL5vM+2TUFsPZh4S
	bfD4/L+gj+7MU8BwugdbgiGe/m8ma4l2M3mkZSQCI25s1+GQQW/Pab5elApaVfsL+Thtno9mIfJ
	iZpcU/mAGy+JpNdTADDsZPGBYT8Q1AwrbO3ztuD5dUgGCArTL7E2YxwKShJ2zHH1hGISbrddOBq
	+ehmohrbB64+a8kXmZdbUyNUobhQenkuVxEi4z4O7KNiEoK37tyj2RKKyniEZddfo9JxcbZzNHg
	m1u+gKXBiRQ/GB/8l9V/k4cg78IPzJU6dv1whjIG87p2DuOa0IC3dzlhLVp3aWwSNhB+OyVeWpI
	QA+PH5CAU54WFdZVE5WoQVXfRZvF0aDb9MvqEKljTMZ4UYhQkK94xO4AiNCX24fe/ltFONrHgjx
	+IucdhXur9vc7sh9A/L
X-Received: by 2002:a05:600c:3b04:b0:490:c6c2:52 with SMTP id 5b1f17b1804b1-49959e016f2mr204095965e9.3.1786183138873;
        Sat, 08 Aug 2026 02:58:58 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995ea2dc4esm123249915e9.13.2026.08.08.02.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 02:58:58 -0700 (PDT)
Date: Sat, 8 Aug 2026 11:58:54 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jakub Kicinski <kuba@kernel.org>, Min Li <min.li@microchip.com>, 
	Paolo Abeni <pabeni@redhat.com>, Petr Oros <poros@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] dpll: use pin owner's dpll ref for
 pin-level attribute setting
Message-ID: <anb91_uhQWVz_oMh@FV6GYCPJ69>
References: <20260807095926.386923-1-ivecera@redhat.com>
 <20260807095926.386923-3-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807095926.386923-3-ivecera@redhat.com>

Fri, Aug 07, 2026 at 11:59:26AM +0200, ivecera@redhat.com wrote:
>Pin-level attributes (frequency, phase adjust, embedded sync, reference
>sync) are properties of the pin itself, not of a particular DPLL device.
>The get callbacks already use only the pin owner's DPLL reference
>(via dpll_pin_own_dpll_ref_first()), but the set callbacks iterate over
>all registered DPLL references and invoke the set operation on each one.
>
>This is redundant because a pin is a single physical entity - setting
>its frequency or phase adjust once through the owner's ops is sufficient.
>Calling set on every registered DPLL just results in duplicate HW writes
>for drivers that share a pin across multiple DPLL devices (e.g. ice
>registers each input pin with both the EEC and PPS DPLL, zl3073x
>registers input pins with every DPLL channel).
>
>Simplify dpll_pin_freq_set(), dpll_pin_esync_set(),
>dpll_pin_ref_sync_state_set() and dpll_pin_phase_adj_set() to call the
>set callback only through the owner's DPLL reference, matching the
>existing get-side behavior. This removes the xa_for_each iteration
>loops, the now-unnecessary rollback logic, and several local variables.
>
>The -EOPNOTSUPP validation loop, which checked ops support across all
>owner-matching references, is replaced with a direct check on the
>single owner reference returned by dpll_pin_own_dpll_ref_first().
>
>The documentation in dpll.rst is updated to reflect that pin-level
>attributes are set through the pin owner's dpll reference only.
>
>No existing driver is affected:
>  - ptp_ocp and mlx5 register each pin with a single DPLL.
>  - ice registers input pins with two DPLLs (EEC and PPS) using
>    identical ops and pin_priv; the set callbacks address the HW by
>    pin index, not by DPLL, so the second call was a no-op.
>  - zl3073x registers input pins with every DPLL channel; the set
>    callbacks address HW by pin/ref ID regardless of DPLL. The
>    ref_sync_set callback was the only one with per-channel behavior,
>    addressed by the preceding patch.
>
>Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
