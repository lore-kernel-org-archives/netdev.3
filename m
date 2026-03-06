Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520F9494A13;
	Fri,  6 Mar 2026 22:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772835001; cv=none; b=gQn8FKIkPgfvMJDfKnQcwtoq90FkLMpwFFEGRUhTtAZhk7S26Kho050r4lmk5Wlc63cBf/9ebGzHET21VMhO2cWqxQyjNn4ufhvF9/C7hcUTvHYQVPHM3yCMfOyRQTA0EadvE+khL3Ery+Ssqq1ZIq5TJWGzMWMC3/vWsbk2Pug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772835001; c=relaxed/simple;
	bh=RYAyxzeSLE7RG7ogsH1lNJ9UT2pOY9bqibfbO9VMaGU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3pMI5d8urF62tXotmAng18U9XdY4tOml/csIUn7UPNiLdCEp97x6q1YUeYvjqWo+QXSAYu6of2H4mzkn0uMGkMhhbd+sB6hPqD9rIkSAQdIL4euVxvD3YNj6VTTlEenkbDGNesg4kDQW2LjKwhBhkhca06seB27N2mta4vjkKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMXlmh4/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMXlmh4/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE78C4CEF7;
	Fri,  6 Mar 2026 22:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772835000;
	bh=RYAyxzeSLE7RG7ogsH1lNJ9UT2pOY9bqibfbO9VMaGU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WMXlmh4/cI1gH8JhsAVVyjOKHtdPp6URvfFSBFYfUhJYzl2V8vPS39wRMeUOKuhGL
	 X6hB70aemwwCiAI1Hvm7Ppphwiqjfmutgn7Xb8ZoOGO1pJtziyRLiNoCcb74t6nXKU
	 x7UervIXEWzEj8ZqipOYJ4B5TgChFNckfpnsvUcyhsBhEWGS93i8IF5zZPYbhwEPBb
	 fuiBvQLTzo1ZwO4CrPY5RHN+MqXWtQ03XkCKbmsS6sZEiAWeeefUr26VLKTC+Ltcq/
	 8Q6k+cxu2iNJWhXUqfYPBsVke2UelwrMv/FwGVZvB6m81qDjKd5JVbljIh67rxWFNP
	 vVv7beqrlMoSw==
Date: Fri, 6 Mar 2026 14:09:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mike Marciniszyn <mike.marciniszyn@gmail.com>
Cc: Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, Jacob
 Keller <jacob.e.keller@intel.com>, Lee Trager <lee@trager.us>, Mohsin
 Bashir <mohsin.bashr@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Pei Xiao <xiaopei01@kylinos.cn>, Stanislav Fomichev <sdf@fomichev.me>,
 Willem de Bruijn <willemb@google.com>, Samiullah Khawaja
 <skhawaja@google.com>, Hangbin Liu <liuhangbin@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/5] eth fbnic: Add msix self test
Message-ID: <20260306140958.42ccee3a@kernel.org>
In-Reply-To: <aasqpPj2rOIKgnSY@PF5YBGDS.localdomain>
References: <20260305150947.16893-1-mike.marciniszyn@gmail.com>
	<20260305150947.16893-4-mike.marciniszyn@gmail.com>
	<aasqpPj2rOIKgnSY@PF5YBGDS.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Mar 2026 14:27:32 -0500 Mike Marciniszyn wrote:
> There is a change in the patchworks checkpatch test the wants to see this as:
> 
> test_data = kzalloc_obj(*test_data, GFP_KERNEL);
> 
> Unfortunately, the net-next repo does not yet have this api and doesn't
> have the checkpatch and the new api that comes in:
> 
> Commit 070580b0b174 ("checkpatch: Suggest kmalloc_obj family for sizeof allocations")
> 
> This looks like the checkpatch.pl in the test is not from net-next/main.

I suspect your local tree is old? Or I don't get what you're saying..
