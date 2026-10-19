Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444323;
	b=2ladoLzvM6ymZ0Aqr3L8RAdfYgArPbw1Nhkh8kblvM2kVphCqSQOzcesKiWxlyRggHdT
	 EOX5UP6hV83hAlDd6hI6UHukQ0FWrshxV/4Udx8MfKlFuxIFnkrEMZIIG//qaz2MH+MJd
	 c/htOh+0KnEcuFnYg6KVle1wTpTlZdRatwBUCJer1pPmaQXxQxYeSUar37w/Uc7rpklOx
	 SUhEXVXIBlScx4IDyB7HNhKO9WZvZpS0U55mIGkFw5BwH4VBzkhPxHz92y4+UPVxLGPY5
	 2EcONplvBTZpLaqm30B5+NuHeCL1lGtgNQrL/+h80O5Uu5sdChHru9dalZ0CM7LPoIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444323;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition:X-Spam-Flag:X-Spam-Score:
	 X-Spam-Level:X-Spamd-Result;
	bh=wk5Go9Qbfzx7UCuPO/qvObUW/F4DcWUvpioYl7ExAhM=;
	b=ddmPSuDiv2kU7wVDh3WjojULYOixaC+1jziOX1mfKCQ3HiSDtuJVarrIn5srOPvgqLqV
	 Q9ehWjOGmTzF+ioqCkkhMf8bZ0YiFhiSA6I5qR2t8NEHralm3D1To/mvYDdB2ggyH0OcS
	 NSb5qGuLZRRuP40aEuNJUlkLTwUAXt0jGOUvx6LinCHnyOhiJD9krdYF/e70W8L8ypWG3
	 +9HY2g6Z4PWMkFE8/RlSv7UzM95FDMzf16fosxX8UtsACf5g2fR4GgylB9Fo+yLukNG4V
	 qz7ZMINKV8YYIOcg0UYLtRsEoyA9Uz7391VkSKdPLsiAFjtQWO14IWT11FxYO7s1H5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=flrY5zZk;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cVcYjiz8;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=flrY5zZk;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cVcYjiz8;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE14606A31B
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 21:12:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DE14606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=flrY5zZk;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cVcYjiz8;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=flrY5zZk;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cVcYjiz8
Received: from lion.mk-sys.cz (unknown [10.149.218.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9916821C98
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 21:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792444320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=wk5Go9Qbfzx7UCuPO/qvObUW/F4DcWUvpioYl7ExAhM=;
	b=flrY5zZkU91THchLMcDSunDibb4NJjHSSU1/6h5w8IXR6eyzvp0NGn/8rt+vXnVeEpSneN
	4y3NFZQ04IYL8zvWwFG1iN17i5ZcaB6MwqnZf4dSO2lGSgAMXxDMBkiisXV69IdXxRv3XD
	ELOiTYEVGz5O4VBrCD0pSCiin50fIGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792444320;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=wk5Go9Qbfzx7UCuPO/qvObUW/F4DcWUvpioYl7ExAhM=;
	b=cVcYjiz8lC+2NIvX4IDC2xfBtfuBPlkvjOhqEx/7c6+OIz/I1I/eu0PY+mIIAL9WiWz8zW
	dn13e+PWs/V7YTCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792444320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=wk5Go9Qbfzx7UCuPO/qvObUW/F4DcWUvpioYl7ExAhM=;
	b=flrY5zZkU91THchLMcDSunDibb4NJjHSSU1/6h5w8IXR6eyzvp0NGn/8rt+vXnVeEpSneN
	4y3NFZQ04IYL8zvWwFG1iN17i5ZcaB6MwqnZf4dSO2lGSgAMXxDMBkiisXV69IdXxRv3XD
	ELOiTYEVGz5O4VBrCD0pSCiin50fIGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792444320;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=wk5Go9Qbfzx7UCuPO/qvObUW/F4DcWUvpioYl7ExAhM=;
	b=cVcYjiz8lC+2NIvX4IDC2xfBtfuBPlkvjOhqEx/7c6+OIz/I1I/eu0PY+mIIAL9WiWz8zW
	dn13e+PWs/V7YTCQ==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 54C942005E; Mon, 19 Oct 2026 23:12:00 +0200 (CEST)
Date: Mon, 19 Oct 2026 23:12:00 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: netdev@vger.kernel.org
Subject: ethtool 7.2 released
Message-ID: <5pwax6gry662nxlc5ndva2fovja5fv6yvvjx7qxkzfsgheowgt@jc4wuskaupn5>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yivxeqs73hbc4hbq"
Content-Disposition: inline
X-Spam-Flag: NO
X-Spam-Score: -5.90
X-Spam-Level: 
X-Spamd-Result: default: False [-5.90 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-0.984];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]


--yivxeqs73hbc4hbq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

ethtool 7.2 has been released.

Home page: https://www.kernel.org/pub/software/network/ethtool/
Download link: https://www.kernel.org/pub/software/network/ethtool/ethtool-7.2.tar.xz

Release notes:
	* Feature: support for KSZ87xx PHY tunables (--{get,set}-phy-tunable)
	* Fix: cmis: fix printing of Tx bias current (-m)
	* Fix: cmis: fix printing of channel-level flags (-m)
	* Fix: cmis: fix printing of CDB EPL pages (-m)
	* Fix: printing of transmitter technology for CMIS transceivers (-m)
	* Fix: avoid undefined behavior with CMIS transceivers (-m)
	* Fix: add missing CMIS transmitter technologies (-m)
	* Fix: printing of attenuation and wavelength (-m)
	* Fix: printing of link length (-m)
	* Fix: sfpid: print all implemented options (-m)
	* Fix: sfpid: print all compliance codes (-m)
	* Fix: qsfp: print all compliance codes (-m)
	* Fix: module-eeprom: clamp data length to attribute payload size (-m)
	* Fix: validate module EEPROM offset and length (-m)
	* Fix: rss: bound hash function masks in text and JSON output (-x)
	* Fix: fbnic: fix off-by-one shift in reg dump parser (-d)
	* Fix: fbnic: Fix various TX and RX CSR fields decoding (-d)
	* Fix: fbnic: Fix register dump names and bit labels (-d)

Michal

--yivxeqs73hbc4hbq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmrWh5sACgkQ538sG/LR
dpU8VAgAvmGy6Rv5E78yGeyIngKFkRRcfF3iz79bA0RtVeRF3BdgmZ+gUERCUk2W
BPNtB56R9Zv2CHPHRbl22GiWNTcOBGdkp6npY2oDOfh0nuag4OBhlIqPPeFOVZF3
nmGktEJsIB/FGX63prOFxmTQTvKmuExmE17kz+dRePHFksFvGRt9dg5iufQAp5Cf
u9efMuftRkqYaVBMxqBunCwvUBeIa78CvMhthG+UQNXzon7VPmSMzhk/6lt3WDCC
J1m6qQynLlCxJjhiIdjgpsa4wlkdpIBft1htkxzHb1pS1V+JhOs5l7FvoHaqQXLP
5f13cCCmYYUTStSKE6mRDWWVhLgX9w==
=Yq+J
-----END PGP SIGNATURE-----

--yivxeqs73hbc4hbq--
