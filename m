Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAA9A95E
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 00:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773187778; cv=none; b=h5Q6XalxjKDT5Aqkzj8irWJaO0Rpi/WTt9eWRO3/z5K754AiH6eKkPt2Fjez9mhBnBpDDDB4kqq7vicg5jmokprbmhWQMGxowQSbeYWKMjO60FiAz/mSD7qcHf8ol3ePRqwAGhPrwoj5Vs5+N4aOgh4j1dMsrfJl1vedj/dRTP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773187778; c=relaxed/simple;
	bh=G+EASqo5sUpecmd/NHO5XZFZ8PZbl576yUz1wTKeVIk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jtyrN6DrBTRPgUagDC4zBHDpfGdkQvretvYoN+JEhWKtkvCNei2JQysaDM/JLFP63FtZIwbO6Iu3FjKFwt1jp4n59cPSZaXV45273GSZT9mCuPpK6yKGZ3rE7qNma8g02xmUwhO5p6A/1bsutgwdYcrtsSrQopXb6cTr812KaHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxUBogDE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxUBogDE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29183C19423;
	Wed, 11 Mar 2026 00:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773187777;
	bh=G+EASqo5sUpecmd/NHO5XZFZ8PZbl576yUz1wTKeVIk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BxUBogDEud91vrfh78nE6b4Psf0sX8c+IxSKV5cvZjPiQq+lV7C8uTr3X4/SPlL/r
	 AstzdooFZue0vECnrRMKFBC+owKjeOlmDTGjZYeBz33tkCK4RF6okZlwT727EN2nKe
	 PKqDT7Kq5K9MZE159ubgG4Vl0jYdSZhk7TbNb9xw+QV/iHOkJV3/pVGSgOeh8lQo/i
	 B6OI2e6azFmokt22bveYZbK3BtOZM58l4PHgI2uyFaOZkW7nd7lvOoaSwy/ogUdpbE
	 Lt27el5LLlGc3PHmsdal92LE0/tcdoPL7Z5wGE5OrQ5/7u6diSOs49Mq47xFCMDLhv
	 6qLwGYh/+Dqhg==
Date: Tue, 10 Mar 2026 17:09:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jakub Ramaseuski <jramaseu@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 przemyslaw.korba@intel.com
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: enable NETIF_F_HW_CSUM
 for GSO packets
Message-ID: <20260310170936.07d429b1@kernel.org>
In-Reply-To: <20260310115556.1004263-1-jramaseu@redhat.com>
References: <20260310115556.1004263-1-jramaseu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Mar 2026 12:55:56 +0100 Jakub Ramaseuski wrote:
> IPv4 over IPv6 GRE currently fails on E810 with skb_warn_bad_offload,
> while IPv6 over IPv6 GRE falls back to software segmentation.
> This happens because the kernel's GSO engine requires the generic HW_CSUM
> flag to trust the hardware with complex encapsulation offloads.
> 
> Add NETIF_F_HW_CSUM to the device's csumo_features to satisfy the network
> stack and unlock full hardware segmentation for GRE tunnels.
> To prevent checksum corruption on standard traffic, evaluate the packet
> in ice_features_check() and dynamically clear the NETIF_F_HW_CSUM bit
> if it is not a GSO frame. This forces the driver to fall back to safe,
> protocol-specific checksum features for non-GSO packets
> while preserving the generic offload for tunnels.

If you're CCing netdev on iwl submissions you have to follow the 24h
min reposting period.
-- 
pv-bot: 24h
