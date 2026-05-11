Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF81402BAB
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514047; cv=none; b=cmkOPDEgFCIxLsJChVhEJMRq3WH5wr3OrmDMXJzZO4EyqRQF7HC2gafo0baINp4B+OX2eQMI/CY/11gEI1DF69/o6IzqW6yhiY3weIMQ/eFHsS/CYRKfcqpZPHiiHn6UPBXKOTnjxNvQ9UbD3D62DSLl+/foDZAM+akSnT8ToAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514047; c=relaxed/simple;
	bh=kMyxVFHBsTENAImGfysO/vdBf+qJS/bcyql+j8HczTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esg0Yt21bOUFqVnwlUhp0+kzaC7USvoSLRnTF8bqnnsVLYap47jrFwIn8jCI1rssMbp1X6QZPSsMcpqzBZ+IFQ223pvqxYGWncrJkKLoAgznYpAn/NkDQN7h8bN5k13TIStfZ2LzRJmhcuoKAssdAOI098SdJgV/KouzktVZar8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+chN3i9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+chN3i9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EECEFC2BCB0;
	Mon, 11 May 2026 15:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778514046;
	bh=kMyxVFHBsTENAImGfysO/vdBf+qJS/bcyql+j8HczTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A+chN3i9ViZ7leomzi38CgzYvReG407/tsMJ6BPiS5NrTI93fdTcUvW3Utxw63crK
	 hLZ90JHMtJa7Tgb8bDPrsgvn3VVh827FJNz1LHHkPy07ii8h6KWsKimQN6SMP4kUcN
	 3qHuYbwdK3VrjzLz/3ZC/8DXzqEdldWhnapacgGOZ8BqXMhaQE9zMelYd+apSVjVzL
	 HftwDDfk43tgLzRzWvct0D0VJa86uw9+MVUSNx+DCzvwACPNPm5xmmYgOmwc4wGY7a
	 yLFlMQL9x2mqMciRTQw280fXeva/UYVK4QS1GKDMAYGWWZt+XaCwVSbiVmp3SntaFh
	 ExBrQpgzyz+jg==
Date: Mon, 11 May 2026 16:40:43 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next 6/8] ixgbe: extract ixgbe_restart_auto_neg() to
 avoid code duplication
Message-ID: <20260511154043.GC27589@horms.kernel.org>
References: <20260508031226.3601800-1-aleksandr.loktionov@intel.com>
 <20260508031226.3601800-7-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508031226.3601800-7-aleksandr.loktionov@intel.com>

On Fri, May 08, 2026 at 05:12:24AM +0200, Aleksandr Loktionov wrote:
> From: Jakub Chylkowski <jakubx.chylkowski@intel.com>
> 
> Both ixgbe_setup_phy_link_generic() and ixgbe_setup_phy_link_tnx()
> end with the same three-line sequence that reads MDIO_CTRL1, sets
> the MDIO_AN_CTRL1_RESTART bit, and writes MDIO_CTRL1 back.
> 
> Factor it out into a static helper ixgbe_restart_auto_neg() and call
> it from both sites.
> 
> While at it, also check the return value of phy.ops.read_reg() in the
> helper and skip the write on failure.  The original inlined code
> ignored the read result and would OR MDIO_AN_CTRL1_RESTART into a
> stale autoneg_reg value (left over from the prior MDIO_AN_ADVERTISE
> write) and unconditionally write it back to MDIO_CTRL1 if the read
> failed.  This is a small behavioral change: on read_reg() failure the
> restart write is now skipped instead of being issued with a
> potentially garbage value.
> 
> Signed-off-by: Jakub Chylkowski <jakubx.chylkowski@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

FWIIW, the AI-generated review of this patch available on sashiko.dev
flags that similar problems wrt write on failre exist earlier on in
ixgbe_setup_phy_link_generic(). It may be good to address this area
more holistically as a follow-up. (I am not suggesting increasing
the scope of this patch/patch-set.)

...
