Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C3E9463;
	Sun, 29 Mar 2026 22:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774823202; cv=none; b=Og5YqWzLEzXXeszM+keIwgkHkmvkH9R6f805I1K3eTJAc3jWkVvPgSniby8QrvrZ9i185gQvb8HEvm5Virn/87Gr9OaN91rSoMRfH13kmObzQ4iMA8QAXIDF7i+kr40EMqlMsspGlymD+3L89nNir2viUWvHS46vUgJNC4ZnEgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774823202; c=relaxed/simple;
	bh=KPxNYFLMKkQB1MP3F1iE6evx43X5GMGgRa4JNxbO3Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aLP+zdBVwsWLurAiV8U5kuWvkXQ6xOgl4yCt5SgWAl8+tcY+recXssPyqqc7UbYIPS6LNHlsdThldh2eqEsdp+AVst0+xcwJrk17ZZeZVSKsyO8UyXWSo+fLlrpJ3O/m07t+Mk4NbT5wIDk9hFUq1gtTCtWBXTvc4SepQSW5R2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WH0IzwMc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WH0IzwMc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE24C116C6;
	Sun, 29 Mar 2026 22:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774823201;
	bh=KPxNYFLMKkQB1MP3F1iE6evx43X5GMGgRa4JNxbO3Lc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WH0IzwMcEYS4P/j1Y0Yp7jBzZdUsb+EPoH3exlMYdGj5P5cklaflYKwORqP4JlHTi
	 15h7KVtF80vCTITxxiuZycjU/7HOWuD57TndbXQ1xQUGv2ifi9urIVylvaH+7Stfs7
	 nCvhTHigzam3Eq18rt2Im1lekdfep82vcxj+8FIe3gy+kqjYs+Mq12Tm/5BDCtScYe
	 jisCFmG3MooeesSC4BvPRkyI6bbFmy/xzaroQJ4d8uPKevyYGgB5LBSkZU1de8UpuT
	 EGSnkwh2mPYX4vM1xN//vNdPGAP2GY9s2CZay9ej7d4AOweQSZcmAwhNm0glz2FciL
	 Pw2q8X7lWwJKQ==
Date: Sun, 29 Mar 2026 15:26:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 andrew+netdev@lunn.ch, horms@kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, linux-kernel@vger.kernel.org, leon@kernel.org
Subject: Re: [net-next v6 11/12] net: netdevsim: Add support for SW USO
Message-ID: <20260329152640.00d52107@kernel.org>
In-Reply-To: <20260326235238.2940471-12-joe@dama.to>
References: <20260326235238.2940471-1-joe@dama.to>
	<20260326235238.2940471-12-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Mar 2026 16:52:30 -0700 Joe Damato wrote:
> Add support for UDP Segmentation Offloading in software (SW USO). This
> is helpful for testing when real hardware is not available. A test which
> uses this codepath will be added in a following commit.

Not sure we need to carry this in the tree.
We have a bnxt device in NIPA, the code will be exercised.
