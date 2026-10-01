Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BB73EB81B;
	Thu,  1 Oct 2026 09:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790845257; cv=none; b=EOSUYKHKMS7LFmz1GHRa7NoFYucAwsv9u8HCZGuISPF9mwH1o8EpC5nTFHn/IS4yYc9alq4ktEZNBZHS2Gi/ZU0ytYrUyXZxnPlY+cbIBkm1WMXXamb42hs5dGzwIMGi3ulnsbuRu+/qZWvHLe03YLyFvWqN1mHMM4jT/AJ+rGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790845257; c=relaxed/simple;
	bh=hUhPUJte1ZSwzAyT4Y1MkM9QOSL5TLUyYCuDiTv2ArI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n8XSU3FhRkLQuY3EhkExZsoBaljXAFCvCT30SVgRvVNwlB6ToWsDm3EH7gmBFJFiE3yRY2rPxAlVwIz3PDqHvPQygqGHgndyZVTb7/+e9AkHyOCJ9/7K9mSXL+tR346eIDsCPS69MktiyvLvzcHqSfKqe4sLK/Zb/LchQkKzpd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVqACOK0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVqACOK0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709361F000FF;
	Thu,  1 Oct 2026 09:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790845256;
	bh=7FpohZnEJYDgmU3T2u3ttgjSXvyGDDs6PkImJs9o6pU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dVqACOK07bbhAenRNC/oZaTcIg1CxR80jNHldj9FJJFYr0nAHd2CqzO4w4177AUWj
	 FhteCpg08Peo+nKHXdmDm/y0ydmiJ7A12mAN1DYlOR5KKvzXeGaFyc8uxQWLav5zjE
	 HstOpX/9YSvxynP2n5Ey1HVCH5zFZV2mX+dv2JCyR0wi4jE5gu5urW8uJw7gK8V7tE
	 eYrHlzIlS4uxeT91hn5NvilyNzcshMjU8vFho+6JH5NJZ27guds0JW4buDjNzQSNNr
	 YLToY5CUKEV39bJevHoYb41RxL2goThzv7f+zZAaKHf7lV/lYzE5AZlGLI6ZXcxPDf
	 87ncap2Ix/DeQ==
Subject: Re: [PATCH net-next 3/4] netconsole: avoid printing partially updated
 target attributes
From: netdev-bot+sashiko@kernel.org
To: gustavold@gmail.com
Cc: leitao@debian.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mpm@selenic.com,
 bonbons@linux-vserver.org, stephen@networkplumber.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 01 Oct 2026 09:00:54 +0000
Message-ID: <179084525499.434549.454029290243818186@kernel.org>
In-Reply-To: <20260928-netcons-fixes-v1-3-bb5ffe5e698a@gmail.com>
References: <20260928-netcons-fixes-v1-3-bb5ffe5e698a@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete for dev_name.
- [Low] The commit 'netconsole: avoid printing partially updated target
  attributes' fixes a user-visible race: configfs *_show() callbacks can…

--

netconsole: avoid printing partially updated target attributes

This patch takes dynamic_netconsole_mutex in the configfs show callbacks
for dev_name, local_ip, remote_ip, remote_mac and the userdatum value.
Readers are then serialized against the store callbacks and should no
longer see partially updated values.

Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260814-netcons_ipv6-v3-7-bc0915e8c75f@gmail.com

> Reported-by: Sashiko <netdev-bot+sashiko@kernel.org>
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260814-netcons_ipv6-v3-7-bc0915e8c75f@gmail.com
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>

[Severity: Low]
Should this have a Fixes: tag?

These show callbacks have read the fields without dynamic_netconsole_mutex
for a long time. dev_name_show() and local_ip_show() date back to
0bcc1816188e ("[NET] netconsole: Support dynamic reconfiguration using
configfs").

The IPv6 rework (for example 56ddc8d48e75f, 46b3f9e7e761d, f6e96d72f64a8)
made the window larger by adding the separate family field.

The other two fixes in this series, "netconsole: finish enabling the
target before releasing RTNL" and "netconsole: read np.dev under the RTNL
in local_mac_show()", both carry Fixes: tags.

> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 5f4311726d11..627475f16383 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -861,7 +861,14 @@ static ssize_t release_show(struct config_item *item, char *buf)
>  
>  static ssize_t dev_name_show(struct config_item *item, char *buf)
>  {
> -	return sysfs_emit(buf, "%s\n", to_target(item)->np.dev_name);
> +	struct netconsole_target *nt = to_target(item);
> +	int ret;
> +
> +	dynamic_netconsole_mutex_lock();
> +	ret = sysfs_emit(buf, "%s\n", nt->np.dev_name);
> +	dynamic_netconsole_mutex_unlock();

[Severity: High]
Does this fully close the torn read for dev_name?

dynamic_netconsole_mutex only excludes dev_name_store(). The netdev
notifier path has two other writers of np.dev_name, and neither of them
takes this mutex.

For an enabled target, the NETDEV_CHANGENAME case rewrites the name in
place. It holds RTNL, target_cleanup_list_lock and target_list_lock:

drivers/net/netconsole.c:netconsole_netdev_event() {
    ...
		if (nt->np.dev == dev) {
			switch (event) {
			case NETDEV_CHANGENAME:
				strscpy(nt->np.dev_name, dev->name, IFNAMSIZ);
				break;
    ...
}

For MAC-bound targets on unregister, release or join, the notifier calls
netconsole_process_cleanups_core()->netcons_release_dev(). That zeroes the
name with only RTNL and target_cleanup_list_lock held:

drivers/net/netconsole.c:netcons_release_dev() {
	do_netpoll_cleanup(&nt->np);
	if (bound_by_mac(nt))
		memset(&nt->np.dev_name, 0, IFNAMSIZ);
}

dev_name_store() refuses to write while the target is enabled, so it
never overlaps these writers. dev_name_show() has no such state check.

So a read of /sys/kernel/config/netconsole/<target>/dev_name can still
race with "ip link set eth0 name ..." or with deleting the device. The
read could return a mix of old and new bytes, or a partly zeroed name.
The buffer stays NUL terminated within IFNAMSIZ, so the result is wrong
output, not an out of bounds read.

This looks the same at the tip of the series. The other fields this patch
touches (local_ip, remote_ip, remote_mac and the userdatum value) have no
writers outside the mutex, so the gap only affects dev_name.

local_mac_show() in this same series already takes rtnl_lock() to
serialize with this notifier. Could dev_name_show() also take RTNL inside
the mutex? That would follow the existing dynamic_netconsole_mutex -> RTNL
order used by enabled_store().

> +
> +	return ret;
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928-netcons-fixes-v1-0-bb5ffe5e698a%40gmail.com
