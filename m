Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2F93A7F58
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771951909; cv=none; b=sERCeTzz71mGF6X6aFY6UmyMn76XBrP2f/xiEbGOSCn/C9KuDJlLwPDLiEklJg9kKKPGneEKpWkXmxtis+sHuyRxhATf3wE6br2A9iOFz6tHuSIJ9k/cYaXTVoPBLekE/hit4aQh5Vbw/uN77qLas1JzKjCbLifJsWhCv6FltVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771951909; c=relaxed/simple;
	bh=NbJZkDphPUQpxbHFYoF66qaDcKzRN4oeXu/r0CVUxhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cg5XKhQmJ25PH3NHwWsC7BrRa+Cbjpb4Jo8aqlOjV+XfzKgaclVyAkhnAHL1ECi8sWxn/uIdTeuhJtfuuHsyiwLbD+JAZJcBq4nGHfGrtYPrv6U0b2nqTp0XPAlzilIK17ojfyilK3f0OIXRPzyHSPIwKv/Cu2Iq91EQ5XeCvuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8t3n5vr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8t3n5vr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D678DC116D0;
	Tue, 24 Feb 2026 16:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771951909;
	bh=NbJZkDphPUQpxbHFYoF66qaDcKzRN4oeXu/r0CVUxhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g8t3n5vrKeBclrgxx/DXcZSaeTJtDIoC7NTnka3pudEyN12jLjzMCfPzRFSwmHvNH
	 cqNjdRGYSj7GqfLEBxbf9rJQH5cnnfXas96W3UUPPGXphKQ6iQgihcCsSxGukNim0x
	 m8o78nbhwzW6h6cgkh5w6DQZRMLyTLfi7MV0cf/lGTiGje8PBMLn6AbdPog3y6hBIo
	 ubbZUxJAh9htnvRPy3iGNi99CBY4Va4P3DJJIfv+sfy8CWDila94nOt8kezpt8Q2ru
	 bPoGQpQD4ujLJZownHPzSU326ehGEEIL0aa2LI/c5z55KnZmBUMKDYU8Y2wEyWXpDb
	 3orzodgnHpCjw==
Date: Tue, 24 Feb 2026 16:51:45 +0000
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org,
	Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
	Anthony Nguyen <anthony.l.nguyen@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH] ice: mention fw_activate action along with devlink reload
Message-ID: <aZ3XIa2a1XiI4cQY@horms.kernel.org>
References: <20260223-jk-improve-fw-update-activate-message-v1-1-ce2b4abcf79f@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-jk-improve-fw-update-activate-message-v1-1-ce2b4abcf79f@intel.com>

On Mon, Feb 23, 2026 at 04:12:17PM -0800, Jacob Keller wrote:
> The ice driver reports a helpful status message when updating firmware
> indicating what action is necessary to enable the new firmware. This is
> done because some updates require power cycling or rebooting the machine
> but some can be activated via devlink.
> 
> The ice driver only supports activating firmware with the specific action
> of "fw_activate" a bare "devlink dev reload" will *not* update the
> firmware, and will only perform driver reinitialization.
> 
> Update the status message to explicitly reflect that the reload must use
> the fw_activate action.
> 
> I considered modifying the text to spell out the full command, but felt
> that was both overkill and something that would belong better as part of
> the user space program and not hard coded into the kernel driver output.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Thanks Jacob, all,

I agree that this text strikes a good balance.

Reviewed-by: Simon Horman <horms@kernel.org>
