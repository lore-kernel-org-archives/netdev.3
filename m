Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5202A344DB5
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 14:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789309183; cv=none; b=ghK8jP7DG5/29L32B/OUK9wYdh9PurJq4WKf7P5f6ly3/OXAULPEZf/4V1MQ0azeU1bemP81wTXh9VxbXlDCtLZuz+jnHtT6HbsnobZlCp7ldk9QATpP5Rpq5rafiM9wvlzRoBnZ4TgL9DejZo7z6EtLoh6XiJYiAqAxX2NXEIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789309183; c=relaxed/simple;
	bh=uZGZOsjvdweVs+Djsjfm+M5sjEv3PWASN94cGllY3Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OjlRVd2aF1vvH17GcNhLlP9ri+BKrAVwQxZWedgJlWwDYRLTs3/SnO0snG4y4X4PEzNjP8MsAK0K1hkWKMRCfd6pzrCWZ9TKTrHswJiItfzOyoZRDbq9i4o0SNeaQesHgigH0BqgNPMYY7zwc6A0ydM+uVFamPQVCnbQU2phKNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gU5OZv/X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gU5OZv/X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447041F000FF;
	Sun, 13 Sep 2026 14:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789309181;
	bh=A26g259BDrlJHZC7IRx34CchJ/YSK3vSxI7SlfEslyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gU5OZv/XdNsmCidptMff2vSq77GUciYmNyI/S8Fdk3S3YqBgzKVD3O4S9Ca4xhDJc
	 L+xNY+vIhVOc8inYBD8CJ11JZtvmTHjJtVSJK5ukFlw3uPHg1a6DgvfuhZ+qkU3DpQ
	 a1/BzdTFW5Jw8fua0mxvpkSGk+ALMY4MgQLshT1wAMZ1R5Pk/0gleIMLnhG11KgK7v
	 ChAVd+BFen9ObWOLu6ntCwZR17RIPT5VAnqK2Qzj9/zcXpv5n6laXb6qfvOTYD3vri
	 OiXgkiTDk5AvrfY4oHesF28hZ0y8ODolyd84+vqRSivkDKx+oSleYnHNevxJJo6oea
	 TFudzyyMU/XSg==
From: Simon Horman <horms@kernel.org>
To: dima.ruinskiy@intel.com
Cc: Simon Horman <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	allen.lan@intel.com,
	acelan.kao@canonical.com,
	kuba@kernel.org
Subject: Re: [PATCH iwl-next v4] igc: Support ACPI-based MAC passthrough
Date: Sun, 13 Sep 2026 15:19:31 +0100
Message-ID: <20260913141931.205787-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910193824.3257378-1-dima.ruinskiy@intel.com>
References: <20260910193824.3257378-1-dima.ruinskiy@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/#/patchset/20260910193824.3257378-1-dima.ruinskiy@intel.com?part=1
---
igc: Support ACPI-based MAC passthrough

This commit implements support for seamlessly passing through a system MAC
address provided in the ACPI table to an I225/I226 network controller
attached via a Thunderbolt dock.

> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 1fb5f3cbe93c5..abffd385f3e8c 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
[ ... ]
> @@ -7106,6 +7108,58 @@ static enum hrtimer_restart igc_qbv_scheduling_timer(struct hrtimer *timer)
>  	return HRTIMER_NORESTART;
>  }
>  
> +static bool igc_get_acpi_mac_passthru(u8 *mac)
> +{
[ ... ]
> +	acpi_status status;
> +	u8 buf[ETH_ALEN];

[Severity: High]
Does this array lack a 16-bit alignment guarantee? 

Because it is declared as a simple byte array on the stack, the compiler is
free to place it at an odd memory address.

> +	int i;
> +
> +	if (!IS_ENABLED(CONFIG_ACPI))
> +		return false;
> +
> +	for (i = 0; i < ARRAY_SIZE(sources) && !mac_found; i++) {
[ ... ]
> +		if (hex2bin(buf, obj->string.pointer + 9, ETH_ALEN) ||
> +		    !is_valid_ether_addr(buf))
> +			goto free_obj;
> +
> +		ether_addr_copy(mac, buf);

[Severity: High]
Can passing this buffer to is_valid_ether_addr() and ether_addr_copy() cause
an alignment trap on architectures that strictly enforce memory alignment?

Both of these helpers cast the pointer to a u16 pointer to perform 16-bit
memory operations when CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is not set. 
If buf ends up placed at an odd address, this could cause a kernel panic.

Could this be avoided by defining buf as a u16 array or by adding an explicit
__aligned(2) attribute?

> +		mac_found = true;
> +free_obj:
> +		ACPI_FREE(obj);
> +	}
> +
> +	return mac_found;
> +}
> +
