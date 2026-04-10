Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936DF298991;
	Fri, 10 Apr 2026 01:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775783443; cv=none; b=rOIDA6m4d3+io05CYUuMpu/xEjzZCcBYYQ++XiIqg1GQdRXsfTeKQndUXHNLnhPbUiNWGsITbsGl7zIMgxMgsD1tKd6mbtarbWZVUw2m694dhRT5hS+ZdC9LDJ8MgSEJsUZxgtVozmETJFozRE+ReB03sOadZfdzKTEUJus0290=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775783443; c=relaxed/simple;
	bh=bOsL/5Ai9nkE51jkRZmv54YIfdu2zvaWVlpTurET71Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LtR9HUkOJlgFf/uVihjmf+p5CCk84xJh4C5N5jKXQTXjNxrLX/+KZ4MYkjw9xW5G2OsEjw0XX6EDcQzStFrACyKY6YdcgaDTo1H/ucCwq2Wcl62a9Dt8Jk7TABGBaLd0RLsWI1t9YA7DdRKwLTrHdUVditsVDsOcZaBe6sgML7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqlNT4PP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqlNT4PP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55413C4CEF7;
	Fri, 10 Apr 2026 01:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775783443;
	bh=bOsL/5Ai9nkE51jkRZmv54YIfdu2zvaWVlpTurET71Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eqlNT4PPbX5lYdH6cHK1Sb/ADvhscQaQLrSaA4bf1TWnsvM1Ms0SDiNYXziLykA4Y
	 YiOvTOJ1CZBsmI34XvT2jH24hf7sfroANf9GVOkSizLCn9rp4ke6E3blQKliphchlF
	 j81dQzdXslxdBuAi1wY3hJsXy94yApGjSVjaZ6sxwgJYAmNJl9c4TRbJAF78vDsiSR
	 giueZKc2SKTmeJf4BQ8NI63DE0NvHHfackHzGwwjUcAfvSOaVaYuVrdejxeqy7dtIQ
	 T3eJdfK6qrv0Nm4MuZwGGsJ6guP6xaSzE1l0uGU+OivfzAdfGW2G8K4ApSBZhAVF8M
	 V4soj1S/G6aHg==
Date: Thu, 9 Apr 2026 18:10:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Oros, Petr" <poros@redhat.com>, "richardcochran@gmail.com"
 <richardcochran@gmail.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Prathosh.Satish@microchip.com"
 <Prathosh.Satish@microchip.com>, "Vecera, Ivan" <ivecera@redhat.com>,
 "jiri@resnulli.us" <jiri@resnulli.us>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>, "vadim.fedorenko@linux.dev"
 <vadim.fedorenko@linux.dev>, "donald.hunter@gmail.com"
 <donald.hunter@gmail.com>, "horms@kernel.org" <horms@kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>
Subject: Re: [PATCH v5 net-next 0/8] dpll/ice: Add TXC DPLL type and full TX
 reference clock control for E825
Message-ID: <20260409181041.395a0c37@kernel.org>
In-Reply-To: <IA1PR11MB621925C1718B838147404DC492582@IA1PR11MB6219.namprd11.prod.outlook.com>
References: <20260402230626.3826719-1-grzegorz.nitka@intel.com>
	<20260406192312.0f7a2760@kernel.org>
	<IA1PR11MB621925C1718B838147404DC492582@IA1PR11MB6219.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 9 Apr 2026 11:21:35 +0000 Nitka, Grzegorz wrote:
> > On Fri,  3 Apr 2026 01:06:18 +0200 Grzegorz Nitka wrote: =20
> > > This series adds TX reference clock support for E825 devices and expo=
ses
> > > TX clock selection and synchronization status via the Linux DPLL
> > > subsystem.
> > > E825 hardware contains a dedicated Tx clock (TXC) domain that is
> > > distinct
> > > from PPS and EEC. TX reference clock selection is device=E2=80=91wide=
, shared
> > > across ports, and mediated by firmware as part of the link bring=E2=
=80=91up
> > > process. As a result, TX clock selection intent may differ from the
> > > effective hardware configuration, and software must verify the outcome
> > > after link=E2=80=91up.
> > > To support this, the series introduces TXC support incrementally acro=
ss
> > > the DPLL core and the ice driver:
> > >
> > > - add a new DPLL type (TXC) to represent transmit clock generators; =
=20
> >=20
> > I'm not grasping why this is needed, isn't it part of any EEC system
> > that the DPLL can drive the TXC? Is your system going to expose multiple
> > DPLLs now for one NIC?
>=20
> Hello Jakub,
> For E825 device, the short answer is yes. We have platform EEC now and
> we want to add:
> - TXC DPLLs per port, and
> - PPS DPLL for TSPLL config purposes (in the near future)
>=20
> EEC (Ethernet Equipment Clock) type DPLL is designed to control multiple
> source signals (internal-NIC or external), where one drives the dpll devi=
ce,
> where multiple outputs are possible, each could drive various components
> as well as propagate signal to external devices.
> TXC is specific dpll device that associated with single ETH port to contr=
ol it's source,
> there is no need to declare any outputs as the single output is already d=
etermined.
> Basically, having TXC DPLL indicates per port control over SyncE (or some=
 external)
> clock source.=C2=A0

Could you share a diagram of how things are wired up?
DPLL can have multiple outputs and multiple inputs. I'm not getting why
a single device would have to have multiple actual DPLLs (which makes
me worried this is just some "convenient use of the uAPI")
