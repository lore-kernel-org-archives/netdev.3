Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E8A356778;
	Fri, 31 Jul 2026 13:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785505076; cv=none; b=Q+eyP9Km8uHkoX60o0GudXHNJBxIErvApLhiy8nAdYrnUeqM1cec6WRJjtmNOCjVNfLni1zM1y8SaPhfbu9p/gydXfc1YSeR7d75mJ0fiNZZLroSgQAzu31amSTfZ2pkX6JQaVBY8nysUxQUuxSK314Nloi1rTcTn3saXum/zl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785505076; c=relaxed/simple;
	bh=YFTVgu+hhjhTdW8M+86i3habqUxkV/paCBkZLVWdbQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2kc6XvhDpDx42ZhM5gcrEZtPM0mhNC/L+pzTgpNX4UB3AdRstMj7KvCnDdwi1b3ugh3xPwZ5V4CYUI31PJEX4c+KlJGeXoS/tjUw0QFk1JVQREvO09orbb0jL7eJPOhHWkHA9DnXfZFywuXDxpO03oJe1fj20+9yYF+iBN+7dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzKap+Tj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzKap+Tj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 162821F000E9;
	Fri, 31 Jul 2026 13:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785505074;
	bh=0K1TzNHf/BmFpZDtuWSqRp/B5F/jJdpqamyw8FfZ1DQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CzKap+TjlS+sd1iHrHkGMv+phvR5TuaudF8O+4uR8aPJvhTleUJzyy0ULeSs4LxVg
	 AQ2cAaxl7vKOWimnCnfgOEjgsYErcgHsTq/z4ppYdTEeuFh1P20ALifstCmaO5T6Lc
	 MeAMKi9L3r4T80NrP9SmnafOrvaIbpOZw10FiNTL46a9zoB2P7q0zUxTS7HJ5+QTY3
	 kdYYYkbVtR7PCEVWCSqbogJLdoaTj1Mb0jI/inxJd3QU88FQ5ALfh7FbTPigkyh5nL
	 XsmHW0g8nju2De4d/ZO6YQoSwEzVOgC32ixVYfU0eA4OZw3UbJE3gwZWHwiVG1Hrp2
	 LDq6BJMf0Bwjg==
From: Simon Horman <horms@kernel.org>
To: pavan.m@oss.qualcomm.com
Cc: Simon Horman <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	qingfang.deng@linux.dev,
	kees@kernel.org,
	ericwouds@gmail.com,
	manizada@pm.me,
	nbd@nbd.name,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] pppoe: Add PPP interface name to /proc/net/pppoe output
Date: Fri, 31 Jul 2026 14:37:27 +0100
Message-ID: <20260731133726.285174-2-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728070636.3462165-1-pavan.m@oss.qualcomm.com>
References: <20260728070636.3462165-1-pavan.m@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/#/patchset/20260728070636.3462165-1-pavan.m@oss.qualcomm.com?part=1
---
--- Patch [1]: [PATCH v1] pppoe: Add PPP interface name to /proc/net/pppoe output ---
commit fe1f42402d1a0992d1fdaf152ef4812c313dc548
Author: Pavan Kumar <pavan.m@oss.qualcomm.com>
pppoe: Add PPP interface name to /proc/net/pppoe output

This patch modifies the pppoe_seq_show() function to include the associated
PPP interface name in the /proc/net/pppoe output. It retrieves the interface
name using ppp_dev_name() and appends it as a new "PPP-Device" column to 
help correlate PPPoE sessions with their pppX interfaces.

> diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
> index 6874a1a8edaf1..cb31f5db43e81 100644
> --- a/drivers/net/ppp/pppoe.c
> +++ b/drivers/net/ppp/pppoe.c
> @@ -963,17 +963,19 @@ static int pppoe_seq_show(struct seq_file *seq, void *v)
>  {
>  	struct pppox_sock *po;
>  	char *dev_name;
> +	char *ppp_name;
>  
>  	if (v == SEQ_START_TOKEN) {
> -		seq_puts(seq, "Id       Address              Device\n");
> +		seq_puts(seq, "Id       Address              Device   PPP-Device\n");
>  		goto out;
>  	}
>  
>  	po = v;
>  	dev_name = po->pppoe_pa.dev;
> +	ppp_name = ppp_dev_name(&po->chan);

[Severity: Critical]
Can this call lead to a wild pointer dereference and a kernel panic?

Reading /proc/net/pppoe invokes pppoe_seq_show() under rcu_read_lock().
However, it appears pppoe_connect() might modify po->chan without RCU
synchronization in a couple of racing scenarios.

First, during a rebind, pppoe_connect() unlinks the socket via delete_item(),
but then immediately zeroes the channel without waiting for a grace period:

drivers/net/ppp/pppoe.c:pppoe_connect() {
    ...
    delete_item(pn, po->pppoe_pa.sid, po->pppoe_pa.remote,
                po->pppoe_ifindex);
    ...
    memset(&po->chan, 0, sizeof(po->chan));
    ...
}

Would a concurrent /proc reader observe a partially zeroed (torn) chan->ppp
pointer here?

Second, during a new connection, __set_item() exposes the socket to
/proc readers before ppp_register_net_channel() initializes it:

drivers/net/ppp/pppoe.c:pppoe_connect() {
    ...
    error = __set_item(pn, po);
    ...
    ppp_register_net_channel(dev_net(dev), &po->chan);
    ...
}

Since ppp_register_net_channel() assigns the pointer with a plain store:

drivers/net/ppp/ppp_generic.c:ppp_register_net_channel() {
    ...
    chan->ppp = pch;
    ...
}

And ppp_dev_name() reads it via a plain load:

drivers/net/ppp/ppp_generic.c:ppp_dev_name() {
    ...
    struct channel *pch = chan->ppp;
    ...
}

Could readers on weakly-ordered architectures observe the new pointer
but read uninitialized memory for its contents?

Since /proc/net/pppoe is world-readable, could an unprivileged user 
continuously read this file while connections are managed, reliably
triggering a local denial of service?

>  
> -	seq_printf(seq, "%08X %pM %8s\n",
> -		po->pppoe_pa.sid, po->pppoe_pa.remote, dev_name);
> +	seq_printf(seq, "%08X %pM %8s %10s\n",
> +		   po->pppoe_pa.sid, po->pppoe_pa.remote, dev_name, ppp_name ? ppp_name : "");
>  out:
>  	return 0;
>  }
