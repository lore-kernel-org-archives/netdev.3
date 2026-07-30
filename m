Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BB84734CC;
	Thu, 30 Jul 2026 23:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785453324; cv=none; b=ml6iow8MqsBB7dG79hRnDcZy3INpFWgGi8sIBsPpVX59fESIEw/wVuL9xnhPr/jpYJX97evsjC4ElbLUhxFwH9sqiD2CBF+uJrj1wgcGA+amlkZMtBlGQdBdpOvQoRERvJEWFmB3QKPYn6ab+122vRZNcsL+s6He6y6KLNigEU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785453324; c=relaxed/simple;
	bh=keWNhaZvAN9UXv6Cklyu/Qy5dBpq2j5/cGuZSJT/4hY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lHRhMNUTPjEKpgRRkMf+605aintmsQVw90tgg8IC4w2Kt0mPqMK0udUecne1SPLYu7kjOp6SSNkYDOrXCj3WhLg4k5HnlGUTBDtB0rRklysR4HsRBlMd+gdnrgWgO4a55MS+gqpVj6jfu3UOC/csOXGyAkrGvDhbMuJ+DzhBoeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhvYvm8u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhvYvm8u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7778F1F000E9;
	Thu, 30 Jul 2026 23:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785453322;
	bh=keWNhaZvAN9UXv6Cklyu/Qy5dBpq2j5/cGuZSJT/4hY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jhvYvm8uUJWeRNdL0c4+CNMzozt9d1q4xDakuCMuT3U5ojJt/kVxjRgzM+EgxrZB1
	 Wdco1BefIYa5VK1zeDDsL1fM1I8PfRikVSf3M/1iAqR2+k91xH+T0ddk++NNaz4pvA
	 U5SDSoVAmsw8V8vtwRJQc5qfBw7DQNSOX+88PkVyaH1j8XNPyeqDa1GCA0NhobXeU3
	 lu7yO/dGWhCoZfSiDrXCx398kmdOcuO6BWWFo9SJ4DQHLAa7BEVAmOwYp6TGxrkoZi
	 QKo9BTsRSM30kTkX/IXGhpcJiuoX5XIPYfZx53PHySzBpcVteDmKCHx0q3NRfa4euJ
	 0qMRs41QHIrtg==
Date: Thu, 30 Jul 2026 16:15:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 kbusch@kernel.org, hch@lst.de, hare@suse.de, sagi@grimberg.me,
 chaitanyak@nvidia.com, gjoyce@linux.ibm.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/4] net: add helper for device lookup by destination
 address
Message-ID: <20260730161521.22695fff@kernel.org>
In-Reply-To: <20260727151652.3660476-2-nilay@linux.ibm.com>
References: <20260727151652.3660476-1-nilay@linux.ibm.com>
	<20260727151652.3660476-2-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jul 2026 20:46:44 +0530 Nilay Shroff wrote:
> Add netdev_get_by_addr(), a helper that looks up the routing table to
> retrieve the network device associated with a destination address. The
> helper also supports netdev reference tracking.

This does not explain why you're doing this.
Please CC the whole series to netdev or write better commit messages.
