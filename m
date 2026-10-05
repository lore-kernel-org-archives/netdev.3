Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654AF495AEC
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 14:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208887; cv=none; b=YtKIZjUjp+v8LiDVttMS7TGo0fYs492JYtbY2lE+zOIM4+e+03bXbdH0AKEsZ/1lTPb1T3khtBELEnkrzloNliHTD11st6cqxh02x+L28un4i5ZYX4OMNQZZjLo0x3mrlvn8isVnmaUo8ge8N+WCwtdSuiEImSzU5GMNX5UfcKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208887; c=relaxed/simple;
	bh=2Oo38g96piuFSTDYK8ZIw6YPORKL+w88v+cSKbW76Us=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cxAjGc8nPs0DYkO2HrJnkhdNON0JbMSL/goqkpLAqX3WbZTZwTMmzlhr8rizvJkkjIRYGZVMb7cm+YyrODphNwpj55qMpaGzZrb5+UO86Mb1e2sT1/LRyiQ3v3QYeOvDNfYpKRFHCCP2n21jHc4/ZqfTWn3u8IZ6nSv0QWTNvM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erzDk+dK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erzDk+dK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747AC1F00893;
	Mon,  5 Oct 2026 14:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791208886;
	bh=aMvtwz0hcjTVkXeK1BAeGN8eZ5ndxGUpWq+RGLXahGY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=erzDk+dKIvRdYVitoWBMDDbmkX/f4co3Ex5vTc4buOFZvN0NImxfxL0WiCynCwkJ6
	 4Z8qr8h8n+WsUbuA5Zlcj3eqgos7VPhJ8uL+dMHc2eViwCTrTsSGSoesTqUpTwfeM+
	 sZepDSTjk8EX4+/ahBcLwp6Th18OI8QiVpJde+XmhGAjB+UtpfiyaOQm/L91Kpl7DT
	 Axp89+YOdLkTaigxdA3Le0ZVvK2N7NOl7B/qXW9O4o+5sfE/Ap+bJ30qp9U3/ViRXb
	 CrEDtNq+gqpY388kabb4EI8kwBrKFzLFbJFYPQvESXyp9IdULWJ7ZvPOu0iSWzYE9T
	 bki7sAmdyPhhw==
Subject: Re: [PATCH net v3] tipc: reject attaching bearer of different media
 to the same occupied device
From: netdev-bot+sashiko@kernel.org
To: tung.quang.nguyen@est.tech
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@kernel.org, pabeni@redhat.com, jmaloy@redhat.com, horms@kernel.org,
 tipc-discussion@lists.sourceforge.net, xujiakai24@mails.ucas.ac.cn
Date: Mon, 05 Oct 2026 14:01:24 +0000
Message-ID: <179120888498.434549.6187275495514737229@kernel.org>
In-Reply-To: <20261001134432.49481-1-tung.quang.nguyen@est.tech>
References: <20261001134432.49481-1-tung.quang.nguyen@est.tech>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete: the new occupied-device check in
  tipc_enable_bearer() (net/tipc/bearer.c:308-311) can be bypassed.
- [Low] The commit message does not match the code.
- [Low] The new check in tipc_enable_bearer() (net/tipc/bearer.c:309-311)
  compares two possibly-NULL results of __dev_get_by_name() without a…

--

tipc: reject attaching bearer of different media to the same occupied device

This patch adds a check to tipc_enable_bearer(). It resolves the interface
names of the existing and the requested bearer to net_devices, and rejects
the new bearer when both resolve to the same device. The goal is to stop
the dev_refcnt leak when, for example, "eth:eth0" and "ib:eth0" are both
enabled.

Closes: http://lore.kernel.org/netdev/20260918013509.1853952-1-xujiakai24@mails.ucas.ac.cn/

> diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
> index 05dcd2f9e887a..f480fffca843e 100644
> --- a/net/tipc/bearer.c
> +++ b/net/tipc/bearer.c
> @@ -285,17 +285,42 @@ static int tipc_enable_bearer(struct net *net, const char *name,

[ ... ]

> +		/* udp media can be used together with any media */
> +		if (b->media->type_id == TIPC_MEDIA_TYPE_UDP ||
> +		    m->type_id == TIPC_MEDIA_TYPE_UDP)
> +			goto priority;
> +
> +		if_name = strchr((const char *)b->name, ':') + 1;
> +		dev1 = __dev_get_by_name(net, if_name);
> +		dev2 = __dev_get_by_name(net, b_names.if_name);

[Severity: High]
Can this check be bypassed when the existing bearer's saved name no longer
resolves to the device the bearer is bound to?

dev1 comes from looking up b->name again. It does not use the device the
bearer actually holds (rtnl_dereference(b->media_ptr) for L2 media).
tipc_enable_l2_media() uses dev_get_by_name(), so a bearer can be enabled
by an altname. That altname can later be deleted while the bearer stays
enabled.

Deleting an altname goes through:

rtnl_linkprop()
  rtnl_alt_ifname()
    netdev_name_node_alt_destroy()
  netdev_state_change()

This sends only NETDEV_CHANGE, and only when the device is up. On
NETDEV_CHANGE, tipc_l2_device_event() only sets the bearer up or resets
it. Only NETDEV_UNREGISTER, NETDEV_CHANGENAME and a bad NETDEV_CHANGEMTU
disable it.

For example:

  ip link property add dev eth0 altname foo
  tipc bearer enable media eth dev foo
      (b1->name = "eth:foo", holds eth0, eth0->tipc_ptr = b1)
  ip link property del dev eth0 altname foo
      (b1 stays enabled)
  tipc bearer enable media ib dev eth0

In the new loop strcmp() does not match. dev1 =
__dev_get_by_name("foo") is NULL and dev2 is eth0, so the check is
skipped. tipc_enable_l2_media() then does:

	dev = dev_get_by_name(net, dev_name);
	...
	rcu_assign_pointer(dev->tipc_ptr, b);

This takes a second reference on eth0 and overwrites eth0->tipc_ptr with
b2. Isn't this the same dev_refcnt leak the commit message describes?

On NETDEV_UNREGISTER only b2 is disabled, because it is the one found
through dev->tipc_ptr. b1's reference and packet_type stay in place, so
netdev_wait_allrefs() waits until b1 is disabled by hand.

If b1 is disabled first instead, that clears dev->tipc_ptr while it points
to b2, and b2 is left orphaned in the same way.

TIPC_NL_BEARER_ENABLE is GENL_UNS_ADMIN_PERM. CAP_NET_ADMIN in a user
namespace is enough to do this with dummy or veth devices.

The name-based lookup can also reject requests wrongly. Suppose the altname
"foo" is moved to eth1, or eth1 is renamed to "foo". A request for eth1
then gives dev1 == dev2 == eth1 and is rejected, although eth1 has no
bearer.

Would it be more robust to compare against the real binding? One option is
rtnl_dereference(b->media_ptr) for L2 media. Another is a check in
tipc_enable_l2_media() that returns -EBUSY when
rtnl_dereference(dev->tipc_ptr) is already set.

> +		if (dev1 == dev2) {

[Severity: Low]
What happens here when both lookups fail? __dev_get_by_name() returns NULL
for a name that does not resolve, and nothing checks for NULL before the
comparison.

Suppose an existing eth/ib bearer's saved altname has been deleted, so
dev1 is NULL as described above. If the request is for an interface that
does not exist, dev2 is also NULL. NULL == NULL then matches, and the
request is rejected with -EINVAL and "Already enabled" or "Same dev for
different media".

Without this check the request would reach tipc_enable_l2_media(), which
returns -ENODEV:

	dev = dev_get_by_name(net, dev_name);
	if (!dev)
		return -ENODEV;

Should a NULL dev1 or dev2 count as no match here?

> +			/* Not allow eth and ib to attach to the same device */
> +			if (b->media != m) {
> +				errstr = "same dev for different media";
> +				NL_SET_ERR_MSG(extack,
> +					       "Same dev for different media");
> +				goto rejected;
> +			} else {
> +				goto duplicate;
> +			}

[Severity: Low]
This isn't a bug, but the commit message only describes the different
media case:

  Fix this by rejecting a bearer with a different media type when the
  device is already occupied.

The else branch also rejects a second bearer of the same media on the same
device when it is named by an altname. An example is "eth:eth0" plus
"eth:foo", where foo is an altname of eth0. This case fails with -EINVAL
and "Already enabled". Before this patch that configuration was accepted
and leaked dev_refcnt in the same way.

The only mention of this is the v3 changelog below the "---" line, which is
dropped when the patch is applied. Could the commit message describe this
case too?

> +		}
> +
> +priority:

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001134432.49481-1-tung.quang.nguyen%40est.tech
