Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793998807;
	b=sjLHWD4GanUaALKFjYUJvy17cVQI9tW8A4yEd7c4rHnT3xoTExEI9TPt5uwkureKMTpc
	 oFGeyXIWSrDJPs0nqF0G4Xrj4XmMcEp1jn/epLJbhQnOuw3+i6d3l/rtnB6IbnLyt2hkT
	 +h4V8FfLR+ADqIw8oA9wCvD+PP2jtsbYMYUMaCXuCnSGDsJi3JQGTrrOT6lRlPC9yZswb
	 nZcWg4LlDIn/aoBpBG0+29MUNxSeyew2oQO9noG5UqO+RbP38/Pmxin0g0fIMO5N+uUfN
	 rGrowL9tgGoPMgPqqsT55aUwbzyT1uFs4lW1htXZcvf56MKl22xINJLdSpoKwLv118A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793998807;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=VZPLtbjG956BLbDUCM34QjUZeBu6jMBP0p7YG8UyO2Q=;
	b=gM8+jNyWaX4e60T+5i4GBsm9if9QHKWF00CCllmCBkxfhMyRQSrxkRbFXqYk3xLEsuVy
	 GvJZHKwWzwLxnhzqKlHMKK21CP0CId/QMxGBc1/IahaUna4qkJyR5vZgX4LE6fGs8Bese
	 QCZaRKzwRJou8/z+Mb7rHDBxhw2XxP+HLeNdiHht2SkawJkQuGKAt8kHkb26VaSumxb0d
	 PSMXVv3I0BskmoCK2taR4JBbZ9LdbT6pv9jS5XOxKDbGCLK/upQM7tjXwRkfW2WL2/rT9
	 yOum3QsBY7gSpogAI4YwhhCTeJ6LHIqzGs+bf1uer28C04xQlGy5CZeudPWcx8WPzog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GBgHSWVt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A106606A334;
	Fri,  6 Nov 2026 21:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GBgHSWVt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363691F0089F;
	Fri,  6 Nov 2026 21:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793998807;
	bh=VZPLtbjG956BLbDUCM34QjUZeBu6jMBP0p7YG8UyO2Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GBgHSWVtRM5OjnwcOu+fr7fbDr/83x4gUDzrUdt/McmdvpdNE02l9X78pJIceVxrD
	 POi8HUJ7bbY1TX56VunTQ4yotbavYrWh5q67kylklbrEDCjec2cZ8QARjz6kLrw1dd
	 rcZ4gW4kZg8wjU1ZZoryn4Ep0e5yR87aL/njDmxAm648cWEb77MWY8VVAUmWWe/Jnw
	 3lfT9AHKXOEZsbWDrZ2pKyVfjQMQol2Ln3vBN66HClmR8wDRRzeQjgpAdlBIBWJeQk
	 KPasrEbNxfbEze7OZ9Xvfo2Cv008IIR26oHT7AklSJgwimh+mNm46Zck7q+IpxasVs
	 MRiLBnzQTSZKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 210C73A549A5;
	Fri,  6 Nov 2026 21:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netlink: Do not call the unbind callback with the
 table
 locked
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179399880568.868572.9395837242230797060.git-patchwork-notify@kernel.org>
Date: Fri, 06 Nov 2026 21:00:05 +0000
References: <20261102120929.4077030-1-anilkaushikwireless@gmail.com>
In-Reply-To: <20261102120929.4077030-1-anilkaushikwireless@gmail.com>
To: Anil Kaushik <anilkaushikwireless@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 nicolas.dichtel@6wind.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  2 Nov 2026 12:09:29 +0000 you wrote:
> When netlink_bind() fails to insert the socket, it calls
> netlink_undo_bind() with the table locked. genl_unbind() then takes
> cb_lock, while genl_unregister_family() and genl_register_family() take
> cb_lock for writing and then wait in netlink_table_grab() for the table
> users to go away:
> 
>   netlink_bind()                 genl_unregister_family()
>     netlink_lock_table()           down_write(&cb_lock)
>     netlink_insert() fails
>     netlink_undo_bind()            netlink_table_grab()
>       genl_unbind()                  waits for nl_table_users == 0
>         down_read(&cb_lock)
> 
> [...]

Here is the summary with links:
  - [net] netlink: Do not call the unbind callback with the table locked
    https://git.kernel.org/netdev/net/c/a36b9e205cb3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


