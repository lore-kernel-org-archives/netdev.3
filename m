Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219213DCD8E
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 16:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775838930; cv=none; b=pDg06kWLJ5nz6EgAgObqnG5DFYJu3x51gjS+yK3MIKTSEnpur49z8JfDnAWyW7iRRS6Js06c0P2KOZbY9sgjeGfmxaQTEoGqCzAaPAB7K0ejkceeq9Daru0jno3kw9RBWDs2Vpk7eaKic9MnLLHodBsRSzAydrF7uviNO215VgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775838930; c=relaxed/simple;
	bh=4bEJckATCQovUDGTXgmxeu6pw7JgXLtzyOhX7nI99Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmnDrcaovDRBR9JOa+osMlWzdI7jOduEJgeyxHvDlHOlNzX29Ae6/5aTdviF4RiFU1Bg+1rcnblH7d/QYCzuYBTf5uGVLlhHjzl2HJBsUpdq/nmHXiz+9tqEKt1J6vSj5QBnw3sIurU0+EZm+5lZ1dw08+51BMFB9ssySDVNqPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=IendoEvj; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="IendoEvj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2k7HVgLatXHkkiYA8xPjMurtGezO58LSDfzc29KudGI=; b=IendoEvjPx6BQP+b/oLMz08CTn
	rIqggQ6Nd/iLqSjdOIyl7QFTVkKuRmzs8oQdvuQ3g7VuKmZKKkJJne1/6beBRCHrKZUYFBCvAPMz2
	pvUzDVFcNT1YCt1cQ9BrBSG8pKlqjMMkBFwcDCh68y2rVgpCQqYVdXl7UE6KS++8KzPhXVlXjFkOE
	gg2J3DsfmX4vjX7ss+jx8NQU+h6gNxyl9LV71Wd1w0QCRSvpxedsuWto9s4jNU9Og8kMzmKz4F0qp
	g6Gn0kKp+u+9LH8zdVOXRF12Omt5r/nfL/F50jtzY7QtZfXVGu2R3Ury2DV+Ymy1CfgSKLIcpy58V
	Zla2tMeQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wBEpK-00A6xC-1u;
	Fri, 10 Apr 2026 16:35:26 +0000
Date: Fri, 10 Apr 2026 09:35:22 -0700
From: Breno Leitao <leitao@debian.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v6 13/14] selftests: net: add
 team_bridge_macvlan rx_mode test
Message-ID: <adkmmM6cCKWqogIx@gmail.com>
References: <20260407153101.3694714-1-sdf@fomichev.me>
 <20260407153101.3694714-14-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407153101.3694714-14-sdf@fomichev.me>
X-Debian-User: leitao

On Tue, Apr 07, 2026 at 08:31:00AM -0700, Stanislav Fomichev wrote:
> Add a test that exercises the ndo_change_rx_flags path through a
> macvlan -> bridge -> team -> dummy stack. This triggers dev_uc_add
> under addr_list_lock which flips promiscuity on the lower device.
> With the new work queue approach, this must not deadlock.
> 
> Link: https://lore.kernel.org/netdev/20260214033859.43857-1-jiayuan.chen@linux.dev/
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Breno Leitao <leitao@debian.org>
>
> ---
>  tools/testing/selftests/net/config       |  3 ++
>  tools/testing/selftests/net/rtnetlink.sh | 44 ++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
> index 2a390cae41bf..38611ea11c6b 100644
> --- a/tools/testing/selftests/net/config
> +++ b/tools/testing/selftests/net/config
> @@ -101,6 +101,9 @@ CONFIG_NET_SCH_HTB=m
>  CONFIG_NET_SCH_INGRESS=m
>  CONFIG_NET_SCH_NETEM=y
>  CONFIG_NET_SCH_PRIO=m
> +CONFIG_NET_TEAM=y
> +CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=y
> +CONFIG_NET_TEAM_MODE_LOADBALANCE=y

Why do you need LOADBALANCE enabled for the test?
