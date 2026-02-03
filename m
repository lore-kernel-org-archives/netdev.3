Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1232C21E6;
	Tue,  3 Feb 2026 02:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770084234; cv=none; b=VyKKJrZmpkUPHbjzA5dn7E6ym0mVy8xbNXm1iFOBYa/hC6SZF2ZA7sQ9Uay1vhFDVfB2POzpSHcWm+ANjjo2ZbfTQiNJNqKnkv2jeQtM0BXFOw8OGfN+1sI+ETLH6wwtShl6hD4ygqkep6s5Cj5Z7b/bwh4MF3BozvLzC4DGe3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770084234; c=relaxed/simple;
	bh=0o4dxLVfIP41ngaZQ8GY7MbXQjIhkffoIiDt6yTHKfw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hcVMQoNvhUoER/rom4+tzPGU++K9jLIngtIg97odwTdKq7x1lm6Ks+AmQOLnK+HrbB3krPJn+bZWwjzsANdly2clSwe2T4E/853tcU82wUCIOlOODni8UIWaKtC7W1MvAluZO2NJCdcaLQo5ArLWwj1dUsEANt4Rt/8GcPxfh/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUtzdcwS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUtzdcwS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810C9C116C6;
	Tue,  3 Feb 2026 02:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770084233;
	bh=0o4dxLVfIP41ngaZQ8GY7MbXQjIhkffoIiDt6yTHKfw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JUtzdcwSYOMoLSy1kPN8yDwXT9CLffc7ECq8QnPquZ0T5p5wklUplxDIE3CwbWmeF
	 No7072iSqKOJk7MkdY5Ull+GespJNAsRId4WUeE/AKzYh1ur7jOpeDzLq7fCAGbZCA
	 w/cevMFoQS5lumIHtkCk4bItJiMb07qKSWVnbCXbckyixpvyYWFGFFm01h8QL0xrUg
	 4h8fPePRsqxRPm5HMAuwykIac8R/KyfOfwzFu7lZtBdVpKFQzWkZGfKoy7akKbWbAN
	 K/BeyQRlGzgeeXwmsCWCCxt2EosgTSUlpab8V7CcfRPJN99asydsmh2sgrW3a6eEFW
	 gYrj1gpm3XgJw==
Date: Mon, 2 Feb 2026 18:03:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vimlesh Kumar <vimleshk@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <sedara@marvell.com>, <srasheed@marvell.com>, <hgani@marvell.com>
Subject: Re: [PATCH RESEND net v3 0/3] disable interrupts and ensure dbell
 updation
Message-ID: <20260202180352.513e6eb1@kernel.org>
In-Reply-To: <20260130141549.827020-1-vimleshk@marvell.com>
References: <20260130141549.827020-1-vimleshk@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Jan 2026 14:15:44 +0000 Vimlesh Kumar wrote:
> Disable per ring interrupts when netdev goes down and ensure dbell BADDR
> updation for both PFs and VFs by adding wait and check for updated value.
> 
> Resending based on discussion with reviewer. 

Looking more closely at this I think the issue Simon flagged is real.
The caller cleans up only the rings for which the init succeeded:

int octep_setup_oqs(struct octep_device *oct)
{
	int i, retval = 0;

	oct->num_oqs = 0;
	for (i = 0; i < CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf); i++) {
		retval = octep_setup_oq(oct, i);
		if (retval) {
			dev_err(&oct->pdev->dev,
				"Failed to setup OQ(RxQ)-%d.\n", i);
			goto oq_setup_err;
		}
		dev_dbg(&oct->pdev->dev, "Successfully setup OQ(RxQ)-%d.\n", i);
	}

	return 0;

oq_setup_err:
	while (i) {
		i--;      
		octep_free_oq(oct->oq[i]);
	}
	return -1;
