Received: from mta0.migadu.com (out-154.mta0.migadu.com [91.218.175.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C0F356A38
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 01:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790558903; cv=none; b=h9b4k1Q+2hmfGQEhG5/SpZehK2tfNJCRLBkzPbKA0gUUYDVvEHsPBHQn23H9+GkCKMPj4BuJk8a2BMXj1wUixxsM8rjWtHBL4bV/dKyUS+2IrPpbK1zr7dpuvSkEFCZiboiupXjk7yyFBbm03kOhl+jdLgrnIjuRkh/HCICVzu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790558903; c=relaxed/simple;
	bh=2ehdvQIsANuzSyhG0PFVkeG3NOTtP55gQMYIpUaKWlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LiCtBisq7KwskXvZTBM35hiCKfX4fg9LSmEMo1tjrnBLlvEzMFiB8d01lLt7pZ2/QC3c8BbJQRVTiufs4wBWNUgogg5rLcTYLXOOv6kIWOieZD3SRfIBGNoJ3z9+TsRg7zeZmP/vG2NeQ/n2SDq2rCX3bNpMvBAWI2W9dL0RGrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KiAafJDw; arc=none smtp.client-ip=91.218.175.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KiAafJDw"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2ehdvQIsANuzSyhG0PFVkeG3NOTtP55gQMYIpUaKWlE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790558898; v=1; x=1791163698;
 b=KiAafJDwEiJHTuFjGg1kdCcAS+gxqU2XMsK+0F8u13ilgu1LEHFqgoz8JuX+nLCaP485EGLz
 GEbAY60R6iue4VUOiO0GF5x5cYOijbPhj+RZx4SGU5oDjjYqLNrErWgxMsEtogAfX7mgVTBhpXp
 L1VC/YaRKsK81jhnRvqjKlhI=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 753f209cd2acc2f1;
	Mon, 28 Sep 2026 01:28:18 +0000
X-Mizu-Trace-ID: 753f209cd2acc2f1
X-Migadu-Flow: FLOW_OUT
Date: Mon, 28 Sep 2026 09:28:11 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Danielle Ratson <danieller@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>, Heng Guo <heng.guo@windriver.com>
Subject: Re: [PATCH net-next v2 2/9] netlink: specs: rt-link: re-align
 ifla-inet6-stats
Message-ID: <arnCq0o5forfSyiz@fedora>
References: <20260925213918.204767-1-ast@fiberby.net>
 <20260925213918.204767-3-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260925213918.204767-3-ast@fiberby.net>

On Fri, Sep 25, 2026 at 09:39:05PM +0000, Asbjørn Sloth Tønnesen wrote:
> YNL enum ifla-inet6-stats got misaligned with C, as two commits
> reordered the enum.
> 
> In commit b4a11b2033b7 ("net: fix IPSTATS_MIB_OUTPKGS increment in
> OutForwDatagrams."), IPSTATS_MIB_OUTPKTS was renamed to _OUTREQUESTS
> and a new _OUTPKTS was as the last entry.
> 
> In commit 652e2c777862 ("net: reorganize IP MIB values (II)"), the
> IPSTATS_MIB_* enum was reorganized for data locality.
> 
> Neither of these commits updated the YNL spec.
> 
> This changed uAPI, as IPSTATS_MIB_* is used as indicies in an u64 array,
> exported as IFLA_INET6_STATS by inet6_fill_ifla6_stats_attrs().
> 
> This patch updates ifla-inet6-stats to reflect both of these commits.
> Next time we want to reorganize these counters we should properly apply
> mapping as to maintain the current order on the netlink side.
> 
> While touching these entries, also remove the dash from ect{0,1}-pkts,
> so that they align with the C naming.
> 
> This pre-existing issue was identified by Sashiko during review of
> commit 2b0aecb7b2b1 ("netlink: specs: rt-link: add accept-ra-min-lft").
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260831093458.472180-1-ast%40fiberby.net
> CC: Heng Guo <heng.guo@windriver.com>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> ---
> Note for Sashiko/Clashiko: Targeting net-next, so no "Fixes" tag.
> 
>  Documentation/netlink/specs/rt-link.yaml | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
> index 8d63933f9910..3560053cea7a 100644
> --- a/Documentation/netlink/specs/rt-link.yaml
> +++ b/Documentation/netlink/specs/rt-link.yaml
> @@ -532,11 +532,21 @@ definitions:
>        -
>          name: indelivers
>        -
> -        name: outforwdatagrams
> +        name: noectpkts
> +      -
> +        name: ect1pkts
> +      -
> +        name: ect0pkts
> +      -
> +        name: cepkts
> +      -
> +        name: outrequests
>        -
>          name: outpkts
>        -
>          name: outoctets
> +      -
> +        name: outforwdatagrams
>        -
>          name: inhdrerrors
>        -
> @@ -587,14 +597,6 @@ definitions:
>          name: outbcastoctets
>        -
>          name: csumerrors
> -      -
> -        name: noectpkts
> -      -
> -        name: ect1-pkts
> -      -
> -        name: ect0-pkts
> -      -
> -        name: cepkts
>        -
>          name: reasm-overlaps
>    - name: br-boolopt-multi
> -- 
> 2.55.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
