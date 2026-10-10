Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AE843F4BF;
	Sat, 10 Oct 2026 09:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791624548; cv=none; b=nwJE0SG0+NKUMGCveJjxdLyEfFirtWGew372Pzjmegpoy/dNlHLtC73ak8bJ3/PJwYI3Ml88NJTJTlE4PVOwXIuepdyJGArEgidhdUwGAAIsI7Pw9jt3K0bXK5trDdX57j3adp0HI/OeTc58c4nGOIGucvPKe4WAHNPOuWLIeK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791624548; c=relaxed/simple;
	bh=et9kr1rotHLJlbfNTw/zrDgfMOHfQCdSCBLho8ZSDlo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FJO2lYx0TcRPMuzxh1aOxGcTnP46aTD9v7dnh9YGhAxUzUk5bIKqiE+i4qZqQTnX2IqMBgodNjM8oQ8Rn9ul4FijnvrXzXrG9dTf457UGRnXltTrQtd6j1Ycdq9FJz/J2zyinDit6yEID9P8YwsVn52739YboJdQpW4no8Fm98g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnZP3zzB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnZP3zzB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1961F000FF;
	Sat, 10 Oct 2026 09:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791624547;
	bh=062KSZ+UWBFFZiFryDmciJibMSf3OCPatS/q1Yu1vLc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bnZP3zzBAF/o8pMzmCXkb5CTvEEkKSsQ7NFfurCOUKLo9BbDE9uEEH18er827NQHY
	 FICn3cK4mD0crTUOv7tKKpVSj7Ca7nEq9T054nbnkiJ1/gcKz/m3xWk3ADNMIgFpRU
	 lHZpPEUE7cqvTwNWpjgZyvgjUV951gc8M0g9J9DokDznj81u7o+JWAeGTi/ULf4hhl
	 aCLDhBQkRWZCg8PvdH96gM1+rj1U03dhlJaPvuuUerj23btR7hLzFlTfcMMCrW6fCf
	 NTptsHy51spI+m7anrDGmxzvL8ZjYNlzhC97nIib6wQLJ0UXZoSRWAnr5SZTFJgDPA
	 kqVXNbaM6TQxw==
Subject: Re: [PATCH net-next v3 4/8] net: qualcomm: rmnet: Restrict supported
 MAP checksum configurations
From: netdev-bot+sashiko@kernel.org
To: subash.a.kasiviswanathan@oss.qualcomm.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, corbet@lwn.net, horms@kernel.org,
 skhan@linuxfoundation.org, rdunlap@infradead.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, lkp@intel.com,
 sean.tranchetti@oss.qualcomm.com
Date: Sat, 10 Oct 2026 09:29:05 +0000
Message-ID: <179162454569.434549.4906466611192508603@kernel.org>
In-Reply-To:
 <20261009084351.317632-5-subash.a.kasiviswanathan@oss.qualcomm.com>
References:
 <20261009084351.317632-5-subash.a.kasiviswanathan@oss.qualcomm.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message presents the new check in
  rmnet_config_data_format_valid()…

--

net: qualcomm: rmnet: Restrict supported MAP checksum configurations

This commit adds rmnet_config_data_format_valid(). It is called from
rmnet_newlink() and rmnet_changelink() to reject any data format that sets
both a v4 and a v5 MAP checksum offload flag, in either direction. The
commit message presents this as preparation for a following coalescing
patch.

> Validate the requested data format in both rmnet_newlink() and
> rmnet_changelink() and reject any combination that sets both the v4 and
> v5 checksum offload flags at the same time, regardless of direction. This
> is in preparation for the next patch where coalescing support needs to be
> allowed with MAPv5 format only.

[Severity: Low]
Is this only preparation, or does it also fix a regression in the current
code? Before this patch, IFLA_RMNET_FLAGS could set both the v4 and v5
checksum flags through rmnet_newlink() or rmnet_changelink(). The datapath
does not handle that state consistently.

On egress, with both RMNET_FLAGS_EGRESS_MAP_CKSUMV4 and
RMNET_FLAGS_EGRESS_MAP_CKSUMV5 set, rmnet_map_egress_handler() picks v4
first:

drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c:rmnet_map_egress_handler() {
    ...
	if (data_format & RMNET_FLAGS_EGRESS_MAP_CKSUMV4) {
		additional_header_len = sizeof(struct rmnet_map_ul_csum_header);
		csum_type = RMNET_FLAGS_EGRESS_MAP_CKSUMV4;
	} else if (data_format & RMNET_FLAGS_EGRESS_MAP_CKSUMV5) {
    ...
}

However, rmnet_map_add_map_header() still sets the next header flag:

drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c:rmnet_map_add_map_header() {
    ...
	if (data_format & RMNET_FLAGS_EGRESS_MAP_CKSUMV5)
		map_header->flags |= MAP_NEXT_HEADER_FLAG;
    ...
}

The MAP header then says a v5 next header follows, but a v4 UL checksum
header is what actually follows. Would the modem receive malformed frames
in that case?

On ingress, with both ingress flags set, rmnet_map_validate_packet_len()
checks v4 first and adds the v4 DL trailer length.
__rmnet_map_ingress_handler() checks v5 first:

drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c:__rmnet_map_ingress_handler() {
    ...
	if ((data_format & RMNET_FLAGS_INGRESS_MAP_CKSUMV5) &&
	    (map_header->flags & MAP_NEXT_HEADER_FLAG)) {
    ...
}

So the length check and the parser disagree on how the frame is laid out.

This patch closes off those states. Should the commit message describe it
as a fix and include a Fixes: tag, so stable maintainers can consider a
backport?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009084351.317632-1-subash.a.kasiviswanathan%40oss.qualcomm.com
