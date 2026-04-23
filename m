Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCE42C11E2;
	Thu, 23 Apr 2026 02:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776912518; cv=none; b=qyydeE/aEKAR2KCBtQjVH51yMBUAfTii5tcxiZ7ABdPrU8/30VrvNtCoIQVElJg2gYonxG3TvTA74SOO9v99xvlop7ASirGF+qPWHs8G5wWO62p1ipp7s8/Wc/7MFc5W5SFfEA8jca9XxBoQLPQaDrIAvOOBkumci6Zffvyq82g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776912518; c=relaxed/simple;
	bh=3d7KUzhhMRXeI8oJPy4/6hc0Gek3mf0WAjET+oOME2A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cnLAKfWkAg+FLqAnOpRohyeX4FVIxlx5HydEvH1znwWotkJLikIKAbpukskdu2jYrKfaCfYy3l1WpOc0IWJzoqereb6pqDibCsQ+jjPny0E91ctfHBYN8fHsJxKlmBo8OW+IrrXlu9b9zi9lwK5ySKeOinEJlR4Ql8lPwLb4lHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWFTU3Jv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWFTU3Jv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13154C19425;
	Thu, 23 Apr 2026 02:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776912518;
	bh=3d7KUzhhMRXeI8oJPy4/6hc0Gek3mf0WAjET+oOME2A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HWFTU3JvsAcKiaW04q8e/1PBOm3FWaxAtCqNUG635XhUdfpQw1t23BJ6PLpv7meOY
	 zEekJPVxB7W/GVIPqiscuJO7FBjwlPXv96hBqJTuwmVmGcL0lb+N8KHqVHHUx94vD0
	 ud73/dsDYic1VqF+3CS95DVpdIv1dGgO/HwwGAer/LCxb2XL4eNNqMNvI+2SpVuthD
	 vr29Vrlyssw/6sAN/KjSWSqOfDvPXJk/XG+bBTh250aWX1d+J/2I49MBoB7zv/Qh7l
	 qjuLhGk/prjLeLJz+9lABDZAcHw0wkFNdJvDEvbiWMQ1XBjd8JJ6PukJ3bIZ1Molkm
	 LlNiX9JlIaMqA==
Date: Wed, 22 Apr 2026 19:48:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] netdevsim: Initialize all fields of ip header when
 building dummy sk_buff
Message-ID: <20260422194837.4ffede4f@kernel.org>
In-Reply-To: <20260421082005.74a3efb4@kernel.org>
References: <20260421073738.22110-1-zlatistiv@gmail.com>
	<20260421082005.74a3efb4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Apr 2026 08:20:05 -0700 Jakub Kicinski wrote:
> On Tue, 21 Apr 2026 10:37:38 +0300 Nikola Z. Ivanov wrote:
> > Additionally remove the now redundant zero assignments
> > and reorder the remaining ones so that they more closely
> > match the order of the fields as they appear in the ip header.  
> 
> Doesn't matter, now that the whole thing is zero-initialized.
> I don't think it's worth the noise in the git history.

I don't see a v2, so just to be clear -- the patch looks good,
just don't reorder the assignments please.
