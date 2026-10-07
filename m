Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C29C24886E;
	Wed,  7 Oct 2026 05:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791351769; cv=none; b=IAnrwGkaA/SbFMBEQvCCy6BtyU/0AH8T8A3HSPBpNicSkDNi/ztsE5oFB+tYYTkuzP9aFtFVPae4cBx4bfF9Wgd++J3b9RUO3yseDfO4EiuHxcA+hWYrA4/PupCuU9FUKJQX33S1glLPdFITyAUsCld+wPCm/xgigu1T8azxgEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791351769; c=relaxed/simple;
	bh=hPTnSr+J/Eb/KAD5TMa/b+7aVwK35JDCbrHzhWCgsj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=huYmSmRQ6nhpyk+522GIpitdysKjzSUMEyb6g/BWqhObgu8y1JrKlSX62ChPvKzLr7VnzPkVaH16DKR4DZ8E6o2Ldi+1L++1OhgfmBHmaYx2hsHrZFE0VaumVqRoFrGTR9KzSuzP1zFGOScipeRfeVBlbEF7wsqJkLsRqDnQJdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AY9Dxy/j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AY9Dxy/j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ECA81F0089B;
	Wed,  7 Oct 2026 05:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791351768;
	bh=KAEW8R1/iA4uJFBGbOhQLHdm+umB4LC33dEe1yZhhc4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=AY9Dxy/jcFdRLCcrj6kd5cnibfRVSu+1282rPTgMkvN29nT019W2KlCIc2XfGhH8A
	 1jq0QcNaF+JPv3VxnisIVh3y4CNyO7fFulPLjydaIwqDoA+zMrC4KoKdS2aQ0iOarE
	 aNK6fyXql3jCy6fB+BlS+BdWdGa69XERqYS4BYRyKk1C3pfNnnyEar5Ff/ToHbtak1
	 7+TYuM6RzbiqTh2/va5EtYITouvtYyfkq4RT4mlWpoDVEN3DfkwkMAm2KsniNFcQY7
	 dXrWaNes81eosknyQF7NSBGy8UypoV2Bkm7xK9vze452jiokKIciWPwO6qVvmlKRu7
	 0x+xIcNvE6D/Q==
Message-ID: <40018dc8-0452-4dfa-95eb-2c401e117c39@kernel.org>
Date: Wed, 7 Oct 2026 07:42:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] netlink: avoid hashing the network namespace pointer
To: Kyle Zeng <kylebot@openai.com>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, outbounddisclosures@openai.com
References: <20261006224149.50498-1-kylebot@openai.com>
Content-Language: en-US
From: Eric Dumazet <edumazet@kernel.org>
In-Reply-To: <20261006224149.50498-1-kylebot@openai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/7/26 00:41, Kyle Zeng wrote:
> The netlink rhashtable key includes a raw struct net pointer and a
> user-controlled port ID.  Both /proc/net/netlink and socket diagnostics
> expose the table's bucket order.  By binding and rebinding chosen
> NETLINK_USERSOCK port IDs, an unprivileged reader can distinguish equal
> buckets and recover the low bits of the Jenkins hash.  Its 32-bit seed
> and the limited set of kernel-image slides can then be searched offline
> to recover the address of init_net.
> 
> Use the namespace's unique, non-address ID in the comparison key
> instead.  This ID is assigned before the per-net initializers run and
> remains unchanged for the namespace's lifetime.  The lookup key and
> object hash are still built by netlink_compare_arg_init(), keeping
> lookup, insertion, removal and rehashing consistent while preserving
> namespace separation.  Neither public table walker needs to change.
> 

Please use net->net_cookie instead.

It has the same value in current trees (net->net_cookie = 
ns_tree_gen_id(net)),
but ns.ns_id only appeared in 6.18, while your Fixes: tag points to
a 2015 commit.

net_cookie is set at the top of setup_net() in stable kernels >= 5.15,
so backports would be trivial.

 >  struct netlink_compare_arg
 >  {
 > -       possible_net_t pnet;
 > +       u64 netns_id;

'netns_id' is confusing, we already have NETNSA_NSID and net->netns_ids.

 > -              !net_eq(sock_net(&nlk->sk), read_pnet(&x->pnet));
 > +              sock_net(&nlk->sk)->ns.ns_id != x->netns_id;

We now dereference sock_net() from netlink_compare(), under RCU,
possibly for a socket of a dismantling netns.

I think this is fine (sockets are freed after call_rcu(), and
cleanup_net() has an rcu_barrier() before freeing the netns),
but please mention it in the changelog.

Thanks.
