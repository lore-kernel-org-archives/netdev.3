Received: from mta1.migadu.com (out-153.mta1.migadu.com [95.215.58.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D7D367F58
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 01:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788487133; cv=none; b=PgM4Bto9Qi0AvmCCM2tdSILV/Ctfa8rq7Sc97M6SHaw7JLDTqnS1w/2aUTfmG8xcBuWbLISZWIkmHYFkpk/NXweeMVK7YdmSUit1puli2UjGzGFtD/xTY5f72oSQeqbykU6zKYhAtUJw4YOiBvXauBhwksu4zK8oAi0X8mq+F2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788487133; c=relaxed/simple;
	bh=2tiMvUnSR/ST76oXDqKEw7ZJIzjM25uNCKR7eJFzWeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmF4FwLpzw0/01Z0R85TjUZVM5qIJU/oyeVxRG3RuEBQt+Ucm9HQgSEUheleQNLlKHg2rw/u9wQBb2m7HjARVPi9xukIMCR+PnXgJFb85+SWQOZRb1HwfiL2+1TX2bM0JAx6H3YazceWSym2Vt+Jn/dZYKlrNrcBzHZTA8zBJ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AGd70xpp; arc=none smtp.client-ip=95.215.58.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AGd70xpp"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2tiMvUnSR/ST76oXDqKEw7ZJIzjM25uNCKR7eJFzWeY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788487129; v=1; x=1789091929;
 b=AGd70xppFXz6nluKNlUNdSH3WjVrtzI0BMt68KwBJT3kN19Rl6c8HMdXRGPVkGFaLxFRRWEl
 9XQ3Es9pazxhDhzLvUDtJr1u6ebUXUkLoliKWs1SalLI05+H0YnkrjmPYIoIGcIAWia9sRxNpuw
 No+u8fh/aMwyzFqJwvkhgtRo=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 70dcb5e667bf1113;
	Fri, 04 Sep 2026 01:58:49 +0000
X-Mizu-Trace-ID: 70dcb5e667bf1113
X-Migadu-Flow: FLOW_OUT
Date: Fri, 4 Sep 2026 09:58:39 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jussi Maki <joamaki@gmail.com>
Subject: Re: [PATCH net v2] bonding: fix slave_cnt leak on XDP error paths
Message-ID: <apolz0n6ktN3yG4f@fedora>
References: <20260903-bond_slave_cnt-v2-1-02e27304ca36@kylinos.cn>
 <62271715-fbd6-4047-9b69-b2bda40db056@kernel.org>
 <fe5f07d4-775c-4fe1-a4e8-384dbc11d7e7@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe5f07d4-775c-4fe1-a4e8-384dbc11d7e7@blackwall.org>

On Thu, Sep 03, 2026 at 02:53:29PM +0300, Nikolay Aleksandrov wrote:
> Waaait a second, it is moved after slave arr update, yes that would cause those.
> I missed it in the review, in my suggestion I specifically said it must be before
> the slave array update because it uses slave_cnt.
> 
> It must be moved up. :)

Ah, I thought all the code between netdev_ops->ndo_bpf and
bond_xdp_set_features() are xdp stuff and missed the bond_update_slave_arr()
in the middle...

I need more careful when go though the code and do testing even with simplest
change.

Thanks
Hangbin
