Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358C6336896
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700654; cv=none; b=Yc5eZXsDM/xlm4pOSqA2npnczynVlsSYxeyDWh+4LvpBGYlf0iJ9HW7e92UeGdSmn+Vyo9AjHfoiPUK5h71gvB4oM4+FYqEILyF7Fx7oG0Ih2Q0X905inQRJp9pKQZsWSNutX7go/RYdeWWpw3fffadusRys6QfDxfGSx9stvpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700654; c=relaxed/simple;
	bh=9kaDUMXd2oMfRaP3QQwYLw5F7z3HDregtskDo9ehssk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcaicLhAX4SAmuMkFX3TmXYxDfjF6YUAbCnjZbC7UgJ+bg76/G+8ytyPbM2g4KHsAf3I4P9hH8NinLGQThBCi69xi0mpU6eTRC4eWHl/6bYDUyafRXdaF5rx0jOKHQdCr1TvGiRmWZLmAunxp6wUvqP0tP+ZKe4efqBHZr99Qn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XP/7zmZw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XP/7zmZw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9779FC19425;
	Mon, 20 Apr 2026 15:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776700653;
	bh=9kaDUMXd2oMfRaP3QQwYLw5F7z3HDregtskDo9ehssk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XP/7zmZw7AEY7/PBkP7ZebSPGwPPDqOQIula7+yGLD2O1a0vVRn/SbytenZ13ZDxC
	 S00nXp7JkJWV+QyirYsELy0jOhSt+ri5etoanqLR+PAMu6/pvrojaslkfRsJbNm3Va
	 xrnntP1tfQB+imr5ubaPOYAiIyzYg8890R2Ye1w7qj4sIlAie/ONQTEbz8VV9PRiZt
	 TVFkM999d74HEsJFpJBNuc/PSoPrabeg1855Q6MJ9tdTVpoC5kj/xAE6Gqy8dVoCQP
	 RuATEOzqwhG3ED6aydqRQXG35Kzqqk3Qc6NEwRvdOBcHYcRtC43kN4GSiBSkdPbKNA
	 dF8d4eEW1qqxw==
Date: Mon, 20 Apr 2026 16:57:30 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Jan Glaza <jan.glaza@intel.com>
Subject: Re: [PATCH iwl-net 4/4] ice: report EIPE checksum errors to the OS
 on E830
Message-ID: <20260420155730.GU280379@horms.kernel.org>
References: <20260417062954.1241900-1-aleksandr.loktionov@intel.com>
 <20260417062954.1241900-5-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417062954.1241900-5-aleksandr.loktionov@intel.com>

On Fri, Apr 17, 2026 at 08:29:54AM +0200, Aleksandr Loktionov wrote:
> From: Jan Glaza <jan.glaza@intel.com>
> 
> For E830 adapters the hardware-reported EIPE (Ethernet Inline IPsec
> Engine) error is a reliable indication that a received packet failed
> decryption and has a bad checksum. Route EIPE errors through the
> generic checksum error path on E830 so the error is visible via
> standard ethtool statistics (rx_csum_bad).
> 
> On previous devices (E810, E82X) the EIPE flag can be spuriously set
> on encapsulated packets with inner L2 padding, so those adapters only
> increment the driver-private hw_rx_eipe_error counter without routing
> through the checksum error path.
> 
> Fixes: 0ca6755f3cc2 ("ice: Add a new counter for Rx EIPE errors")
> Signed-off-by: Jan Glaza <jan.glaza@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


Sashiko has provided review of this patch. However, I don't believe any of
the issues flagged there should block progress of this patch.

You may wish to look over that review for possible follow-up activity.
