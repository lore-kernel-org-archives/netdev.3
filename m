Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A121E418A5C;
	Tue, 14 Jul 2026 19:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784056507; cv=none; b=GkKRggC06VZpWWD1UK9YxAXJE5UebMDCEEWoRCXRmxxNoOhDUpSldV62beXZ5YrMYY6PViTsrCpP14fm3R0ykByqLMZbwTcdGaO1hWIDkj/PTWARlHetVQTsmmwpv/p1Iyt88dK83vgbKVUxWVMt9HCIddx3BYnK+hHMcdCkndw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784056507; c=relaxed/simple;
	bh=p0wmZLOKDngMCtvjd+Iw+F/TFcdzRjhdAPjVktGfQrU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2uHtWEv/qQo5wyyylamlgvgApMBEB200uvXKfyAXVYmVDrCZvYmlUaZv1YhAUyLFzd6KzkJ/TEJhph9agx4RAhzBBR37Vjd4TZzrtG854uE5lqs2P4beyXF23Z9fKv25RP6ejx9ary6ktY06C8/SIZsUduD/CQ/yHwAdQrkCp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wjiaq-000000006sq-0Sxh;
	Tue, 14 Jul 2026 19:15:00 +0000
Date: Tue, 14 Jul 2026 20:14:56 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/4] net: dsa: mxl862xx: add devlink
 flash_update and info_get
Message-ID: <alaKsBXSK9tP__O8@makrotopia.org>
References: <cover.1783988826.git.daniel@makrotopia.org>
 <5d1614d1cd6b99bf0f0635c6370bbed10736a7fa.1783988826.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d1614d1cd6b99bf0f0635c6370bbed10736a7fa.1783988826.git.daniel@makrotopia.org>

On Tue, Jul 14, 2026 at 01:51:02AM +0100, Daniel Golle wrote:
[...]
> +	if (!of_property_read_string_index(ds->dev->of_node, "compatible", 0,
> +					   &compatible)) {
> +		ret = devlink_info_version_fixed_put(req,
> +						     DEVLINK_INFO_VERSION_GENERIC_ASIC_ID,
> +						     compatible);

Review of the fwupd counterpart of this series[1] made me reconsider
what the driver reports as the "asic.id" fixed version. The devicetree
compatible string used here ("maxlinear,mxl86252") turned out to be an
unfortunate choice as the comma is awkward for userspace consumers, so
for v3 I plan to follow the mv88e6xxx example and report a chip name
from a per-model info table instead:

  fixed:
    asic.id MaxLinear MxL86252

Before sending v3 I would like to clarify the preferred format of the
value. Existing implementations differ: mv88e6xxx reports for example
"Marvell 88E6085", including the vendor name and a space, sja1105
reports "SJA1105E", hellcreek reports "hellcreek", and bnxt and ionic
report bare chip identifiers.

Documentation/networking/devlink/devlink-info.rst only describes
"asic.id" as "ASIC design identifier" without any format constraints.

Userspace builds firmware matching identifiers from these values, in
the case of fwupd for example

  MDIO_BUS\COMPONENT_fw&ASIC.ID_MaxLinear MxL86252

and while a space works there, such identifiers commonly avoid spaces
in favour of underscores, hyphens or dots.

Is there a preference for new drivers? Should the vendor name be part
of "asic.id" as done by mv88e6xxx, or would a single token such as
"MxL86252" be more appropriate?

[1] https://github.com/fwupd/fwupd/pull/10667
