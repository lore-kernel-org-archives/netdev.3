Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFD12E62A9;
	Mon, 20 Jul 2026 23:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784590731; cv=none; b=PWY8+R/cbFV4mp5T5Oyrew2/ENLJHjdsyK0uSYKsjsIJcNBU0y3zi/m9uGz+Xp8PbEy8mhD9RysunfgEWLEqYMGNan8HWu6kONXKQe0fq4/AHbAC0HHvn8b9+R3uNjJgffCkzBG51sBOY4nE/rrxD8f15uvenTS7nsLjYgU1zzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784590731; c=relaxed/simple;
	bh=IomDt+9LJn4OXvd0o8F7s5oDthywhTWKehQf/5LMBr0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MaWErhNWRD5zMeslD00dA5617lJHYIxULRMVDXGgjtHlOmQjMpcxIIMdOiiKm1a+tmPfrddbXokX2CDuUufaTXctyWlY2yTjEhJlYs0pVqpZv+fhDZX0Ott8B+QvlysAsSl0UszTYe19/C65ngCOnCpiqV5W2Oncd9qc25IdSAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeZqZoLg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeZqZoLg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B291F000E9;
	Mon, 20 Jul 2026 23:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784590730;
	bh=Tz0Rs3hAdBoRgU0ivVumzrNyY9dPXvZX92ea3NzVa74=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MeZqZoLgAMpkHYoolyrbUVC4QeyUqkVkO+HwMELe7Ay8uapyBNriyhhDtGDcq1otU
	 0Rzby9tmZBq/z2C5obI3pM2mVPC5VR8PHdgox/aHGVjTLViX1OrOLUvHoSXSwjKV+0
	 NkN4TNPCTJ+82o6sutnSWTi1gv1MsFfkysCYekfwSc6/sAKuBUJuyiB7iAIWg0JG1b
	 M+M6P3lRLWYdqWMsNPeLHSM/oXdvYdX/q0OdUtOE8r7WlQuRVpm8aW7tVhtOvqeRkT
	 V9CYDTUHq5G3eOyIfJqHpE7MEp8wNxVYJpM2kWYP0aV6MGnsb3Gc+VOjDOJwvsu1x3
	 nnI3TVOf1KdnQ==
Date: Mon, 20 Jul 2026 16:38:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hanson Wang <hanson.wang@ugreen.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, oneukum@suse.com
Subject: Re: [PATCH 1/1] net: usb: aqc111: fix set_mac_address return value
 for bonding
Message-ID: <20260720163849.557b37ea@kernel.org>
In-Reply-To: <20260703073936.462231-1-hanson.wang@ugreen.com>
References: <20260703073936.462231-1-hanson.wang@ugreen.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  3 Jul 2026 15:39:36 +0800 Hanson Wang wrote:
> -	return aqc111_write_cmd(dev, AQ_ACCESS_MAC, SFR_NODE_ID, ETH_ALEN,
> -				ETH_ALEN, net->dev_addr);
> +	ret = aqc111_write_cmd(dev, AQ_ACCESS_MAC, SFR_NODE_ID, ETH_ALEN,
> +			        ETH_ALEN, net->dev_addr);

nit: sashiko suggest the indent of the continuation line is off, which
seems true. Please fix this and repost
