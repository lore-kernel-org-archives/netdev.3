Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793515120;
	b=IeaInDB4mYOocN4c/33UGH6euvdCnvwuNG33BdWunqIrNT1pl3/2ILuOq2DpVhnQ79zV
	 poTRo+XWJABEXZuunAttDZBBGbAphfy/rImeQOsExOeszzWVGXa8UsGJ9h3UuZFoeYjoK
	 iLt4IeDG0CkuTQn31MKAuqRPbzKurXIUH4GJUZhNtfeRNEYfA5rg1U5CpUAxyHr+v5lyd
	 HpoiHJY1oir/AibXjW0u5hfzVswTo++YFV7yABdp3XT3kiWFFpPpOV+xqBweTZaY3fx5D
	 zoFb05LChFizrrdkkNf1nDDHLmAh7cY91HQy3m3f6/rPjPnngTjG5vD6lo74yEEWw9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793515120;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=BfLyU2cS2xA7FeYeiHmkusAvazgpl2MWCKLPXLWBwRE=;
	b=lcBHDrj3PSMSBlHwYH0hzEJz4ruVO3vyHz4ZpcvppeqxcdsMyLOuNhAAv/5dJCGpMooX
	 MEQgL+ii4awYSWYX7c+K3lfgO602KfGtfyzfx7648PQa84nV53YTly/oEU0hwmuYwcU/g
	 p0wZkvCUa2hcVFeCJ4aQN4lzoTEyORhBHBD4IdRbVflcSKClh+zGeOKmTJNIcfYsiKZZw
	 8zDJ8QIlUCHCH8hnh7a1kbw9GbNEW/UuGzGgMcu1l5Y+MFFirHtJcucvgEW8neYN/0pDT
	 +WUkV55Cu+16w+xyo/drniEp5pTG5xdyyWRPt2BD3NtHPWX471b/yL9hHNCMQ2uiL9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eMm3NTVB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB410606A325;
	Sun,  1 Nov 2026 06:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eMm3NTVB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE2581F000C1;
	Sun,  1 Nov 2026 06:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793515119;
	bh=BfLyU2cS2xA7FeYeiHmkusAvazgpl2MWCKLPXLWBwRE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eMm3NTVBb+3L3e3c9BzWgKYDN4usEHD0BJ2hJ4V/lwk8rf9D2qJb78pOvkWS8U1Bg
	 CKF+qNN/9zJFYxUBt3EFXZJ7mdRHoBTwl/tsAsPdm1pvDenfw0Qvc84Hqk0sgUPsVj
	 AMihlC4H4YstOR5n8Md43tnv3m+qC1CRxcz8QaG4r6mX+LWvL+DHZd/p7UqkOganYa
	 3gbJtfClRMlXWCq4XPTI7o8049XNpX7NNKjCe0P+0niMy8y/bo+yBUOfnSH8g5nVkZ
	 wewA0873Y4T1hoWN4O8bjXVRQFwcMXOCqCljV3VFhkDfCP37bWz/gbhtW8UjkjT3xP
	 H8mkln9oIolCg==
Subject: Re: [PATCH net v2 1/2] genetlink: Reject joining multicast groups no
 family owns
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, idosch@nvidia.com,
 nicolas.dichtel@6wind.com, jacob.e.keller@intel.com, jiri@resnulli.us,
 v3rdant.xiang@gmail.com, aliceryhl@google.com, linux-kernel@vger.kernel.org
Date: Sun, 01 Nov 2026 06:38:38 +0000
Message-ID: <179351511832.3131.17059702072211202236@kernel.org>
In-Reply-To: <20261031054632.3697295-2-anilkaushikwireless@gmail.com>
References: <20261031054632.3697295-2-anilkaushikwireless@gmail.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] genl_bind() checks ownership and GENL_MCAST_CAP_* under
  down_read(&cb_lock) and releases the lock before the caller adds the…

--

genetlink: Reject joining multicast groups no family owns

This commit makes genl_bind() return -ENOENT when no registered family
owns the requested multicast group ID. Before this, such joins succeeded.
The socket then stayed a member if a privileged family was later assigned
that ID.

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

[Severity: Medium]
genl_bind() checks ownership and capabilities under down_read(&cb_lock),
but it drops cb_lock before the caller installs the membership. Can the
owner of the group change in between?

In netlink_setsockopt() the membership update is a separate critical
section:

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

The window in netlink_bind() is wider. netlink_lock_table() and the
insert/autobind step both run between the per-group genl_bind() calls
and the netlink_table_grab() that updates nlk->groups.

Consider this sequence:

CPU0
setsockopt(NETLINK_ADD_MEMBERSHIP, X)
  genl_bind()
    family A owns X with no GENL_MCAST_CAP_* flags, ret = 0
    up_read(&cb_lock)

CPU1
genl_unregister_family(A)
  genl_unregister_mc_groups(A)
    clears members of X (CPU0 is not a member yet)
    clear_bit(X, mc_groups)
  idr_remove(&genl_fam_idr, A->id)

CPU2
genl_register_family(B)   /* B has a GENL_MCAST_CAP_NET_ADMIN group */
  genl_allocate_reserve_groups()
    find_first_zero_bit() returns X

CPU0
netlink_table_grab()
netlink_update_socket_mc(nlk, X, 1)

Would the socket then belong to B's privileged group without passing a
capability check? Nothing seems to check that membership again later.

The follow-up commit "genetlink: Clear stale members when assigning
multicast group IDs" adds a genl_clear_mc_users() call to
genl_validate_assign_mc_groups(). That handles a stale membership that is
already installed when B registers. In the sequence above, though, the
clear runs before CPU0 installs the membership, so it finds no member.

The follow-up's commit message says:

  No socket can be a valid member at that point: cb_lock is held for
  writing, so genl_bind() cannot see the new family yet

Does that reasoning miss a socket whose genl_bind() already passed for
the previous owner, with its membership update still pending?

To trigger this, A has to be unregistered inside the window, for example
by rmmod, or by a module init that registers a family, then fails and
unregisters it. B also has to get the freed ID. An unprivileged user can
trigger B's registration through CTRL_CMD_GETFAMILY and request_module().

Would serializing the check with the membership update close this
completely? That could mean holding cb_lock across both, or re-checking
under netlink_table_grab().

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261031054632.3697295-1-anilkaushikwireless%40gmail.com
