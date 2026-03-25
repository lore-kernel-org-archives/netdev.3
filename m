Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433B3322B6F;
	Wed, 25 Mar 2026 18:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774463029; cv=none; b=Wa9wEDFJb4KJnsDUFk4QbCCaB+xhnjxQe1GxUezBFTJ5oQvzzidMeAwT/e4bR15kwGRreUxuWYRlfjhETX1QXIgsNqgGKkfvY+txxIKcKU+Epeiqi/SmC783ecs5kqEU+CS5GIlKJaWmUZqE4Lb5O2rd9hn85GVvIdoF5v14Q5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774463029; c=relaxed/simple;
	bh=nBn2nZjTfztH1lv0HnoqNWloCjqqGTTd9IMY5ZhQDL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7G4u1VC0MDDOcT3ZeL8bNn1DiH9hw2x8rpFO24PRN2JdA20kNOew0XKwzUB+SSyleogSVT0jzpvqES89fhOwQ5N+0WY6A3+33bi15KMUnTdEZk6tnOOxS9KXMbxoNCdP6GS6fppZ9Ck0+Uz788YU/IRc29ZdPJYib+EgG0hjiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXsJ97zZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXsJ97zZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7F2C4CEF7;
	Wed, 25 Mar 2026 18:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774463028;
	bh=nBn2nZjTfztH1lv0HnoqNWloCjqqGTTd9IMY5ZhQDL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rXsJ97zZmaSqQVzbhdNuoItIZLxFOjbuk3+n3+lpPOkwlFN5qouGPqWogWg/jeIZi
	 RjtppZAB8JctkgP1eqRcj8rwTLJFQEF0Wf/GxMyGae2+SPQtWrFGWJUVSAO9k54VHX
	 1VUS8lkkLeTiRkDNxgI4bRIpK0Puat40vlkIkHmNZojvzoJORteshzFWn07Ai0oqYk
	 XBHxFbIBCbPGviAPEsZQ1X/DKFKgd1rclpWwdiL2wkzio+9AtbsywvzD8Q66qwrxQU
	 TAyu9Z20ut1we6X1sh3X6OMwhHOrJ8fiLVj5qAwW4coj/cjUmSjO/yrjJnpKezm56y
	 14V0CFG52lpKA==
Date: Wed, 25 Mar 2026 18:23:44 +0000
From: Simon Horman <horms@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+006987d1be3586e13555@syzkaller.appspotmail.com,
	Manivannan Sadhasivam <mani@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] net: qrtr: replace qrtr_tx_flow radix_tree with
 xarray to fix memory leak
Message-ID: <20260325182344.GN111839@horms.kernel.org>
References: <20260324080645.290197-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260324080645.290197-1-jiayuan.chen@linux.dev>

On Tue, Mar 24, 2026 at 04:06:44PM +0800, Jiayuan Chen wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> __radix_tree_create() allocates and links intermediate nodes into the
> tree one by one. If a subsequent allocation fails, the already-linked
> nodes remain in the tree with no corresponding leaf entry. These orphaned
> internal nodes are never reclaimed because radix_tree_for_each_slot()
> only visits slots containing leaf values.
> 
> The radix_tree API is deprecated in favor of xarray. As suggested by
> Matthew Wilcox, migrate qrtr_tx_flow from radix_tree to xarray instead
> of fixing the radix_tree itself [1]. xarray properly handles cleanup of
> internal nodes — xa_destroy() frees all internal xarray nodes when the
> qrtr_node is released, preventing the leak.
> 
> [1] https://lore.kernel.org/all/20260225071623.41275-1-jiayuan.chen@linux.dev/T/
> Reported-by: syzbot+006987d1be3586e13555@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/000000000000bfba3a060bf4ffcf@google.com/T/
> Fixes: 5fdeb0d372ab ("net: qrtr: Implement outgoing flow control")
> Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>

Reviewed-by: Simon Horman <horms@kernel.org>

