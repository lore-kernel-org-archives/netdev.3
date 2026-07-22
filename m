Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078C9317163;
	Wed, 22 Jul 2026 21:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784754155; cv=none; b=NXnaTTc4QaIVxuAgNfdBUfUzhyplcNGm+qTsA5QaxDuv3uJRrZTEZGDZS1eiIKiUJZCW2D7yjnuP91uifKCjjzeiy53D4MkcavW1zaHgFqjn9msj0It1TzDXtTbTz8fclOzl2sp4hMCSAdJCUSyiooVDPZfq1a0axDATSIlASDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784754155; c=relaxed/simple;
	bh=kh/QHtnyAGIxjY1XBVrQ7nL8KJbhXSDECJX9vxRNIXM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LyLc05Fbr2jh9TUoHCZnxqFDygd24c/wQf0SDHuXeR4yRksSXNi70OYXY9WCnib1AYHCRPdX5oRcGMAaB4yxFwMgwFJiLxxbt1fqwYnOzHUNcg/cilXnI8ZPwr4upVBQSn9L8dw2jIAFNUalvhH3oQykGLu4lc8jKragkeSfh2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjJuSbIR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjJuSbIR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073761F000E9;
	Wed, 22 Jul 2026 21:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784754154;
	bh=kh/QHtnyAGIxjY1XBVrQ7nL8KJbhXSDECJX9vxRNIXM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WjJuSbIRkRjQui/vuEr4SmiwQOWLVFBN0tlW9Ct9Kn920BoG2AAxVpjnE+hKDr8kd
	 5+UNLcxvhRUZU8k7+UYQ4hWLWjYThSyKeJ0g9vK8m2cYQcAWfFwQBOnt2iYI4tU3NL
	 9majlritgXHSDzuXDtoxT46v+v9pvfxMY4p01YRhkPRE8CaF0LYaGiRokZZvP5x+TN
	 1GPRaqFcGGFBLCz25BKhSHGDaBJbZHPsd7qt3mUDVMo9hLnLaZsz52H9Mwu7smG78G
	 ZjXYSuAar8d7ET2Bukl74X9i2HamyewN7gnRFBdXZtJFMUno7klyQ+ssLN8ndlZouu
	 GZVDxJR7MmLhA==
Date: Wed, 22 Jul 2026 14:02:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
 <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>
Cc: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org, Aleksandr
 Loktionov <aleksandr.loktionov@intel.com>, Grzegorz Nitka
 <grzegorz.nitka@intel.com>, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net] dpll: use pin owner's dpll ref for pin-level
 attribute reporting
Message-ID: <20260722140232.7a8401d9@kernel.org>
In-Reply-To: <20260714125945.1823269-1-ivecera@redhat.com>
References: <20260714125945.1823269-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jul 2026 14:59:44 +0200 Ivan Vecera wrote:
> Commit c191b319f208 ("dpll: allow registering FW-identified pin with a
> different DPLL") relaxed dpll_pin_register() to let fwnode-identified pins
> register with DPLLs from a different driver. This allows, for example, the
> ICE driver to register a zl3073x-created pin with its TXC DPLL using
> ice_dpll_txclk_ops, which lack frequency_get and phase_adjust_get
> callbacks.

DPLL maintainers, please review.
