Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793400033;
	b=re0SholfyNY+yaWwxPgydsVF68wHClF5krODU29hkNPAv4ERXIetjV3r1LOBjGn7cm38
	 NfgONRJM130QkS9G7xAlMzVBlanW5iPT8IzYP0NPZwGnKihh3+UML7kz4WQjNdcrUDA4R
	 xCeeAol2zXxUSdRIm+mSvXzfrvpF+com1AwJGHuwebGvXhaSnqQFFt8zWTXHk0ZxkfSOT
	 iDp7V01iT5eqkrjiz+Jl8mXgFAbsn2q9hyW/VsbArKUJfTxmfCW6AringxsMl78bSL8pL
	 gmsGAc3DIZm7i9wDH/z4Fa35jgRkA7AvfuG6Aep/7dGPGEAh6AiVTKqier8/0k4pk7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793400033;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=RzzWVhBwctPLl5vkJHCmyC9VNdTXXXJa8A/zWY/C3CA=;
	b=XJTIPpgnN95xT8rDVmX2IImJ6pQpWIfhNQ9I544qg8akLnKlcqHP5c2rPIYLqoy9//Yj
	 hIJtlfD+wg/Sw3ZZG2nKbl1RR59P4osgGmV26SF11/Wuedv1CPI5Tshln6/vU7X6ucXm/
	 QXHDYRdMwgjt7OycHOOJNnUkf0FBuHRYmEetfMcQJ48SwzYDLFkL1kZFAZxjH2CNKp5uN
	 hlElOfbo3W/2ri5eNUSVHlZrZu2V7eAnbuLCqGTDhVcnxwvkTgy/k7XqJnJgNxl3pNiVX
	 VjzruueYLKXp9k721flhrSfIWmVdfso7FVW3CSSgvl2hZAbwb9epqKzoIClcc2L6CTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DgjS2Jko;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72A4606A333;
	Fri, 30 Oct 2026 22:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DgjS2Jko
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AEA1F000C1;
	Fri, 30 Oct 2026 22:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793400032;
	bh=RzzWVhBwctPLl5vkJHCmyC9VNdTXXXJa8A/zWY/C3CA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DgjS2Jkon2GSzzEl8G0UKsG2Y7JNRvoEbNUA3XG4cM67DSth8TJnVfQEvDIcHpPU9
	 jprJWZvLfNs3X0Hs95FnLGgwo/eye7SmFMO2MFqRE/mLAmPYweR092T06EKwl+TYQI
	 4gkzbSROFh3Y5JHJkfoWXH59/vXhrOFJATYAJSZ8ttMvvjWxNcYxfXbCSQhm5zm2+b
	 moye3Rl9VTqm5e4CTD8R9zjtLrNnqkygMw/9C0AbCC5YkS3yuQRLazLFfVqxn/0pyn
	 sqFss0bGoj94AuXhDYYK35ZDLL722E+V43SDzk0PClJOo4Zqt1a7zgBYTg1Fq4aEh2
	 updJUETFowEIw==
Subject:
 Re: [PATCH net] genetlink: Reject joining multicast groups no family owns
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, idosch@nvidia.com,
 nicolas.dichtel@6wind.com, v3rdant.xiang@gmail.com, aliceryhl@google.com,
 linux-kernel@vger.kernel.org
Date: Fri, 30 Oct 2026 22:40:31 +0000
Message-ID: <179340003139.3131.11274717768928642724@kernel.org>
In-Reply-To: <20261029062214.3407223-1-anilkaushikwireless@gmail.com>
References: <20261029062214.3407223-1-anilkaushikwireless@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete because of a check-then-use race.

--

genetlink: Reject joining multicast groups no family owns

This patch makes genl_bind() return -ENOENT when no registered family
owns the requested multicast group ID. Before the patch such joins
succeeded. If a family with GENL_MCAST_CAP_* flags was later given that
ID, the socket stayed a member.

Link: https://lore.kernel.org/netdev/179324692107.3134.14443689892607921337@kernel.org/

> diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
> index 5cc1037d4917e..f038f04ef4ead 100644
> --- a/net/netlink/genetlink.c
> +++ b/net/netlink/genetlink.c
> @@ -1825,7 +1825,7 @@ static int genl_bind(struct net *net, int group)
>  {
>  	const struct genl_family *family;
>  	unsigned int id;
> -	int ret = 0;
> +	int ret = -ENOENT;
>  
>  	down_read(&cb_lock);
>  
> @@ -1841,6 +1841,7 @@ static int genl_bind(struct net *net, int group)
>  			continue;
>  
>  		grp = &family->mcgrps[i];
> +		ret = 0;
>  		if ((grp->flags & GENL_MCAST_CAP_NET_ADMIN) &&
>  		    !ns_capable(net->user_ns, CAP_NET_ADMIN))
>  			ret = -EPERM;

[Severity: High]
Does this fully close the case described in the commit message?

genl_bind() checks ownership and the GENL_MCAST_CAP_* flags under
down_read(&cb_lock). It drops the lock before it returns. The caller
sets the membership bit only afterwards:

net/netlink/af_netlink.c:netlink_setsockopt() {
    ...
		if (optname == NETLINK_ADD_MEMBERSHIP && nlk->netlink_bind) {
			err = nlk->netlink_bind(sock_net(sk), val);
			if (err)
				return err;
		}
		netlink_table_grab();
		netlink_update_socket_mc(nlk, val,
					 optname == NETLINK_ADD_MEMBERSHIP);
		netlink_table_ungrab();
    ...
}

netlink_bind() follows the same pattern. It updates nlk->groups[0] under
netlink_table_grab() after genl_bind() has returned.

The owning family can be unregistered inside that window, for example by
a module unload or by a module init that fails after
genl_register_family(). Can the following sequence happen?

CPU1 (unprivileged)                  CPU2
netlink_setsockopt(ADD_MEMBERSHIP, G)
  genl_bind()
    down_read(&cb_lock)
    family F owns G, no caps, ret = 0
    up_read(&cb_lock)
                                     genl_unregister_family(F)
                                       down_write(&cb_lock)
                                       genl_unregister_mc_groups()
                                         __netlink_clear_multicast_users()
                                           (CPU1 not a member yet)
                                         clear_bit(G, mc_groups)
                                       idr_remove()
  netlink_table_grab()
  netlink_update_socket_mc(nlk, G, 1)

After this sequence the socket is a member of a group ID that no family
owns.

Later, genl_register_family()->genl_validate_assign_mc_groups()->
genl_allocate_reserve_groups() can give G to a family whose group has
GENL_MCAST_CAP_NET_ADMIN or GENL_MCAST_CAP_SYS_ADMIN, such as psample,
mptcp pm, ioam6 or cifs. Nothing clears the existing members of G at
that point. do_one_broadcast() delivers based only on the membership
bit. The CTRL_CMD_GETFAMILY->request_module() autoload path from the
commit message could still trigger that registration.

That is the end state the commit message says is fixed:

  "A family registered later can get that ID, and the socket stays a
  member: nothing checks it again."

Would it be more robust to clear existing members of newly assigned
group IDs in genl_validate_assign_mc_groups()? That could run under
netlink_table_grab(), the same way genl_unregister_mc_groups() clears
them on removal. It would cover both the original case and this race,
instead of relying on the check in genl_bind().

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261029062214.3407223-1-anilkaushikwireless%40gmail.com
