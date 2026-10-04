Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249BE3F412B;
	Sun,  4 Oct 2026 06:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791093951; cv=none; b=u21ku9A5YbZJ8DADePa+jifuvPJQ9ZBOekAkIyY743o16emM8U9b83CH6G+lEN9giQewxv05kYEpSZWz+yR9znc6616v2PcXz+2MGD+vVroU5hN+hJUnYyMIvppjMj4PbdhKi1UJCoU1MBFTBeb/xmBvpgXbQ0x/KC61Bwb0SA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791093951; c=relaxed/simple;
	bh=YXyd/6Tn4sPJw/tIRJ0jRYGQArS/XZSTVmilz5b9Mrw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rDXlYv/MI7Yc2/r1Uh2FGPjd8mDhQ8UTZzBSJwnNVOb0XlqlCAhKyppJaWFMP5ndHqqFHl51qBHwbSOmHNGZXte/9/NGA/TOjfMHXSrskQXpnljcnd15YFf6N4nZsRSifTFsO2EfZ2BjR0cb7sdvR7WTsXpRfGdKiRvK0aPvSxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmloydcY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmloydcY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3EE51F000FF;
	Sun,  4 Oct 2026 06:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791093949;
	bh=CZ27R9s2YQGoBt5SJELz/aNz0LHBCdZotV23XMw04+8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GmloydcYIUeo2Ae3+1gxb3sVinm/ku9VNU0XXdCjFBTMHbrGgObrhXJEMagziu4X/
	 BCv8LQqhG050cK/N5tBAwONcDQ58i3j+9LNP9et1ZTJuEKETfFux7xFIlQqkoCS3XX
	 PMgiTtiTfB9g7fgnJfFjCGsCa6mSxqwa+NCVtzcvrmYrSEMT2UPgBmyf+RUWHnpt6+
	 SgqY1YaAluJ3m7aXcGNcB8vwIXHIPu1FPKf+8pwALQNOT6XClnd5Z9x4MVDnTD632G
	 pq14mFBDFz3BAe8CnArlkUUlY7rAwYmelyUvJrqeXYLgxnRuDhxdGO1kRze/NO18OH
	 wy+o71Z6HWgiQ==
Subject:
 Re: [PATCH net-next 1/7] uapi: if_link: Add RMNET_FLAGS_INGRESS_COALESCE
From: netdev-bot+sashiko@kernel.org
To: subash.a.kasiviswanathan@oss.qualcomm.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, corbet@lwn.net, horms@kernel.org,
 skhan@linuxfoundation.org, rdunlap@infradead.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 sean.tranchetti@oss.qualcomm.com
Date: Sun, 04 Oct 2026 06:05:48 +0000
Message-ID: <179109394824.434549.15865500494405113153@kernel.org>
In-Reply-To:
 <20260930051345.857443-2-subash.a.kasiviswanathan@oss.qualcomm.com>
References:
 <20260930051345.857443-2-subash.a.kasiviswanathan@oss.qualcomm.com>
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

- [Low] Retained for independent validation only; my baseline decision is
  FALSE.

--

uapi: if_link: Add RMNET_FLAGS_INGRESS_COALESCE

This commit adds bit 6 to the rmnet ingress flags in the uAPI header. The
bit lets rmnet process incoming packets in the MAPv5 coalescing header
format.

> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index 245b362045253..349fcddc6622f 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -2022,6 +2022,7 @@ enum {
>  #define RMNET_FLAGS_EGRESS_MAP_CKSUMV4            (1U << 3)
>  #define RMNET_FLAGS_INGRESS_MAP_CKSUMV5           (1U << 4)
>  #define RMNET_FLAGS_EGRESS_MAP_CKSUMV5            (1U << 5)
> +#define RMNET_FLAGS_INGRESS_COALESCE              (1U << 6)

[Severity: Low]
This is a minor point about bisection. Nothing in the kernel reads the new
bit at this commit, so it is accepted without any effect.

rmnet_newlink() and rmnet_changelink() in
drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c merge the requested
flags without checking them:

rmnet_changelink() {
    ...
		data_format = old_data_format & ~flags->mask;
		data_format |= flags->flags & flags->mask;
		WRITE_ONCE(port->data_format, data_format);
    ...
}

rmnet_fill_info() then reports port->data_format back. The bit shows as
enabled, but __rmnet_map_ingress_handler() and
rmnet_map_process_next_hdr_packet() never check it at this point.

Later in the series, "net: qualcomm: rmnet: Add DL packet coalescing
support" adds the code that reads this bit in the ingress path and in
rmnet_map_data.c. It also adds rmnet_config_data_format_valid(), which
rejects RMNET_FLAGS_INGRESS_COALESCE when RMNET_FLAGS_INGRESS_MAP_CKSUMV5
is not set. So the gap only exists in the middle of the series.

Would it make sense to fold this define into that patch? The bit would
then never be accepted by a kernel that ignores it.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930051345.857443-1-subash.a.kasiviswanathan%40oss.qualcomm.com
