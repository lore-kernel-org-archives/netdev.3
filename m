Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE50837CD47;
	Mon, 23 Mar 2026 21:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774300763; cv=none; b=Ws6J720c5FuK/t74gd9dr53yp9KEK9fJf6IEoOCFNErvhDCWoTOLgJYk3Lo2pu6puD8b9aYtQIAV0si6c+uJCBbFBjriOS73tJlJBNFQx45JBTSPpKWtENZOOwpCl73221NHG/uOlhymseWZRF23RXlrLc6u6Uz5j1HWh4E5eLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774300763; c=relaxed/simple;
	bh=++5w7WAFq1NpP/9k0jG7HJmewsr67dfHeMWia/coHjI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HZgLhhfIZFX9ugWXKFU5w4qKRqiqD8gdQ8WjYn8lhMMkUbFB4hr8k27KhNIaBUPhHhyNFoQZUkoMVc9HnpJodEfnehlzkBbGo8Sw8ZHOnNO80qbL+Wbbbvv7xGWP0JodDd/hjvJEbQXLCJ8MSylHcWziTy22yEw8WQoRRL1BudM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIF/XgrC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIF/XgrC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C976C2BC87;
	Mon, 23 Mar 2026 21:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774300763;
	bh=++5w7WAFq1NpP/9k0jG7HJmewsr67dfHeMWia/coHjI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pIF/XgrCFEpz3gQexV4ogxaRJvAKWvvDVh2ROnptetq7JfJscqKb22M4uYfdLZwKV
	 fN13P3ojwW20IrFpdF+pFPAo56oWnmIzUOWx/O6oLJvSftMnJDFMoUlotADXJR3a/q
	 Yh6YKeWgeq9kaX8o/lWqlTvVQ6r5pi+PXyuTO85yaJnIHm8ILGp3utnMvnHZg+yFwe
	 UKdF9U+bGTNPm6b9oN5qKvnrvlicSuFTKDeAd/W4q0vsW8ja47fi8djO5d+6ytrRxw
	 LfkjZAjWYjhgnnhmpyZ8YOCSiDpIT4XhCum2y4U3djBdh66OXLCHo2uuJJKr//2veV
	 kcvnfz30BXaHA==
Date: Mon, 23 Mar 2026 14:19:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, poros@redhat.com,
 richardcochran@gmail.com, andrew+netdev@lunn.ch,
 przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
 Prathosh.Satish@microchip.com, ivecera@redhat.com, jiri@resnulli.us,
 arkadiusz.kubalewski@intel.com, vadim.fedorenko@linux.dev,
 donald.hunter@gmail.com, horms@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com
Subject: Re: [PATCH v2 net-next 0/8] dpll/ice: Add TXC DPLL type and full TX
 reference clock control for E825
Message-ID: <20260323141918.7863c85e@kernel.org>
In-Reply-To: <20260321222627.1193603-1-grzegorz.nitka@intel.com>
References: <20260321222627.1193603-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Mar 2026 23:26:19 +0100 Grzegorz Nitka wrote:
> NOTE: This series is intentionally submitted on net-next (not
> intel-wired-lan) as early feedback of DPLL subsystem changes is
> welcomed. In the past possible approaches were discussed in [1].

drivers/net/ethernet/intel/ice/ice_cpi.c:178:2-3: Unneeded semicolon
