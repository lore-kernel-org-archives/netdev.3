Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86863A7F41;
	Tue, 18 Aug 2026 19:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787080277; cv=none; b=Wc9mWtLOLHQGjEh3t5Cxoxe7O1/RXDK7VDAUnFPPI6xClKhVGOOlZHxksw3Kqc+ayP5PdvYMxKB3GG5sUA/OeqM0xF4KrN3PwyG+LbVwjiov+YVgiLTQKy8P/KAZqV0M0UOy4/RtA9+vA8mqz2r+qGGffY9AGSL2nqWcUflStGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787080277; c=relaxed/simple;
	bh=HoGkY5auIou4pLwyM5yTrJzBNyMHjxN87yrvYPyk2pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n14EcBeLgR6CwtZu73OeXn6AtgsMQ/1tIogVcCr+LFAHZESpycdVwQul0L7/ydloXN/atuxHXq5BdrR3bw5RXhhTgtfvV7ompnh1miUFwOGLvDoHXovie5ujbBgn5U7Z/maoV831o5yBLpH9ceILlipNv2qu1YbV0DtsUNa9m8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEYSULiH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEYSULiH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2D71F000E9;
	Tue, 18 Aug 2026 19:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787080276;
	bh=CmDb2knTC5ep3vyIeWqUF5fC8E/mg7myErS7a6E/tro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bEYSULiHf53V5M8lq8g7q/X7gZF0Rh2tfPI0cMdJaehcgnl0VyPFKdp6XTVsB60/+
	 UVcLxGcgduQEfoUvr4GivaGnKi9zyOm7YrrBbEbmHH7WXiJsB7v7l46sFnvUkgCQvn
	 WchgPw1Oa2lcsmUh+dfloMDV5+3ZQZMzuxMVzQm1Lf65L9liNZ1eKLSbpRYbJVx3og
	 LlvxCyB6qGz5+7p9xLhEQFeLADaFHsytYZ9XmZ6o9Hew5QPUJrpFNoFA+tzp+kdd9C
	 HdPpfP0aOlux2fS1Ftrt/946ENJnwr3ShKCcs3UsfEcV+W7c4SCZG5rOXBzgQYsRCx
	 4jybb0ElmZ3DA==
Date: Tue, 18 Aug 2026 20:11:10 +0100
From: Simon Horman <horms@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Michal Michalik <michal.michalik@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-net v3] ice: propagate ETH56G deskew poll failures
Message-ID: <20260818191110.GK265046@horms.kernel.org>
References: <20260815135700.54202-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260815135700.54202-1-pengpeng@iscas.ac.cn>

On Sat, Aug 15, 2026 at 09:57:00PM +0800, Pengpeng Hou wrote:
> ice_ptp_calc_deskew_eth56g() ignores the return value of
> read_poll_timeout(). If register reads succeed but the DESKEW valid bit
> never appears, the timeout is treated as success. If a register read fails,
> the poll condition can also inspect deskew_i before a successful read and
> continue polling instead of stopping on the hard error. The function then
> returns an int error through its u32 deskew return type.
> 
> Return the deskew value through an output parameter. Stop polling when
> either the read fails or the valid bit appears, then propagate the register
> error or the poll timeout separately before calculating and applying the
> deskew value.
> 
> Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
> 
> Assisted-by: Codex:gpt-5
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
> Changes since v2: https://lore.kernel.org/all/20260706144325.91320-1-pengpeng@iscas.ac.cn/
> - capture and propagate the read_poll_timeout() result
> - stop the poll immediately on a register read error
> - initialize deskew_i before it is used by the poll condition
> - do not carry the v2 Reviewed-by because the poll logic changed

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

