Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9B61F91E3;
	Tue,  7 Apr 2026 02:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775528594; cv=none; b=QDkBN45dqdwwtnuzwo7bHILPFOv2R8MWGJEEWp8bvlKwOuAT9Gs6lf/cWhRZ+CN1u7JIoaqVjXVWxx57J3kSrfJrsEzcUINGYtNMip2NQclw1/jUVltaHHoQ5SiCodT8Iugk3WVll3LAu8/RZ5Tw/fzAoi1daZmfQ40+7XLEyK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775528594; c=relaxed/simple;
	bh=J3G58NtGbvUyzKFU/bUdQFTxP5xxRhZEkzXFIq5Rduc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=llXZXZACa+xkSDoBpasOTzUgLL9ksylGAn9Sr7+om2jwr2GcUaD7FjmnRCLMR8vncYbYk1xtiqjL5n6KdTcfyzzsNF55HPgxtd2MknOIDL42DnKJ/M+AKdRorVIOCqXbW4x/vzR5IRvDzdCAGHj4tHrN2BTSUr1rf++GkQXLho0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dd8dQAQc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dd8dQAQc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A46C4CEF7;
	Tue,  7 Apr 2026 02:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775528594;
	bh=J3G58NtGbvUyzKFU/bUdQFTxP5xxRhZEkzXFIq5Rduc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dd8dQAQcF0Pgr/mecx4sBWjNfNCim71nTp5J6mUHfx4MMbJgGpzdZ06ftrKs0GcaR
	 e5vkwdJYQTahgggjKrwUSpoiiUU7N0tA67vfupAkvOIFowI9gKSu1Kir4qaxQ2rc5s
	 Hk4MzvSziczHaw5PdZgjIiF9CbdD7LCgeyKaymJpskj+eqVKr6j7c0evit3/pH6gGo
	 rZ1OmuF1jyOaBbAyW7tB8BIup5AQ+p0k60zm0uuT0PXnyldxiaEoOc9gwnXRdjQ1/e
	 FcZ/0sm2fz0gIx83zdOlxj2nlQr2HopHpYMonRay88uUzpt3qcj8uZNNwrcsj0WtM2
	 6Rk85JDS7vG0A==
Date: Mon, 6 Apr 2026 19:23:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, poros@redhat.com,
 richardcochran@gmail.com, andrew+netdev@lunn.ch,
 przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
 Prathosh.Satish@microchip.com, ivecera@redhat.com, jiri@resnulli.us,
 arkadiusz.kubalewski@intel.com, vadim.fedorenko@linux.dev,
 donald.hunter@gmail.com, horms@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com
Subject: Re: [PATCH v5 net-next 0/8] dpll/ice: Add TXC DPLL type and full TX
 reference clock control for E825
Message-ID: <20260406192312.0f7a2760@kernel.org>
In-Reply-To: <20260402230626.3826719-1-grzegorz.nitka@intel.com>
References: <20260402230626.3826719-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri,  3 Apr 2026 01:06:18 +0200 Grzegorz Nitka wrote:
> This series adds TX reference clock support for E825 devices and exposes
> TX clock selection and synchronization status via the Linux DPLL
> subsystem.
> E825 hardware contains a dedicated Tx clock (TXC) domain that is
> distinct
> from PPS and EEC. TX reference clock selection is device=E2=80=91wide, sh=
ared
> across ports, and mediated by firmware as part of the link bring=E2=80=91=
up
> process. As a result, TX clock selection intent may differ from the
> effective hardware configuration, and software must verify the outcome
> after link=E2=80=91up.
> To support this, the series introduces TXC support incrementally across
> the DPLL core and the ice driver:
>=20
> - add a new DPLL type (TXC) to represent transmit clock generators;

I'm not grasping why this is needed, isn't it part of any EEC system
that the DPLL can drive the TXC? Is your system going to expose multiple
DPLLs now for one NIC?

> - relax DPLL pin registration rules for firmware=E2=80=91described shared=
 pins
>   and extend pin notifications with a source identifier;
> - allow dynamic state control of SyncE reference pins where hardware
>   supports it;
> - add CPI infrastructure for PHY=E2=80=91side TX clock control on E825C;
> - introduce a TXC DPLL device and TX reference clock pins (EXT_EREF0 and
>   SYNCE) in the ice driver;
> - extend the Restart Auto=E2=80=91Negotiation command to carry a TX refer=
ence
>   clock index;
> - implement hardware=E2=80=91backed TX reference clock switching, post=E2=
=80=91link
> - verification, and TX synchronization reporting.
>=20
> TXCLK pins report TX reference topology only. Actual synchronization
> success is reported via the TXC DPLL lock status, which is updated after
> hardware verification: external Tx references report LOCKED, while the
> internal ENET/TXCO source reports UNLOCKED.
> This provides reliable TX reference selection and observability on E825
> devices using standard DPLL interfaces, without conflating user intent
> with effective hardware behavior.

