Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7D654654;
	Fri, 19 Jun 2026 00:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781830582; cv=none; b=odlZd4oq3c8xaYiPoLSBVukQtjd+A2KTw8K/fm6gGtM3Cfwyw2HyPi8Dn+WD+K3IHS+EtPcmtZ0k/hKXjxY9uzHmr83JJaMe2VTWA8wx84Xx3Mw9YIHynRCUsaeX9GAp3nF7O8VG+9qdz6Kuj2uyfWS8tTIeRFEpGYFyWnTCz4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781830582; c=relaxed/simple;
	bh=OMHydIANu1o6UY/V/GnGmH8MKgNzsKxLVznwgMJGMfs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HosIcL9DXnQ1d8XQxCybIqVikGFdi5xeeuM6vYIjI7iJzm1+DgcxCeJfXPknqmtfdNbaYsGJKAGtASN+uXv+VfhlofBysZQP9OLcW0W5oGZSTiRhZdTcSFUp6QHgd2PBXY46W6lwZRJs4cAsR2VA5DI/0xz2/Quy57Qz1CjfZ8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9hcEDBA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9hcEDBA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865991F000E9;
	Fri, 19 Jun 2026 00:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781830581;
	bh=BLHuCpwcCI0cZ7RukXDPSnWbikFTyCQbuDZK/f3vLdI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=R9hcEDBA1Zowa5TPQxBp5uPBhjHJU8jJuZaKzZaBQDOcZ42yrZgx7IYJGm66fnRN5
	 xVTb0ZgJsjreF7qey2sHR7YGdGFBXiQySJBCF8DKtx+ATO6UwqiUxV3t/MtIPF92PE
	 XnNP3vDLgBZWMRKpOq4sJdzb4yP+XqNMPpO4qalDQzrok1mNs+XUJcUMnfDzgQCvDI
	 HzDlIBJzdcoCMvL4wVEd3CF+BVhN3CqC8xjvDl+zr3znsSizkD8+Bb1eeEJIEth0BN
	 L7tshDiKS0qnSt7zqin5VgQItkip0yLFq+Pv2WpqUry4zGJP6lsuXnvyosdfXrvA0j
	 nvRLqnAwuYhvQ==
Date: Thu, 18 Jun 2026 17:56:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
Cc: Wells Lu <wellslutw@gmail.com>, Andrew Lunn <andrew@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Shitalkumar Gandhi
 <shitalkumar.gandhi@cambiumnetworks.com>
Subject: Re: [PATCH net v2 0/2] net: ethernet: sunplus: spl2sw: fix of_node
 refcount leaks
Message-ID: <20260618175619.671a4025@kernel.org>
In-Reply-To: <cover.1781552725.git.shitalkumar.gandhi@cambiumnetworks.com>
References: <cover.1781552725.git.shitalkumar.gandhi@cambiumnetworks.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jun 2026 01:20:30 +0530 Shitalkumar Gandhi wrote:
> This series fixes of_node refcount leaks in the Sunplus SP7021 ethernet
> driver, found by inspection. Compile-tested only; no SP7021 hardware
> available here.
> 
> Patch 1/2 fixes the phy_node leak in the remove path.
> Patch 2/2 fixes multiple leaks in the probe path and depends on the
> cleanup contract from patch 1/2.

Wells Lu, please review.
-- 
mping: SUNPLUS ETHERNET DRIVER
