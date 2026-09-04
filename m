Received: from mta0.migadu.com (out-149.mta0.migadu.com [91.218.175.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA901374A1F
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 01:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788485467; cv=none; b=n59qyQDHG8EhELYmJG2lwUsgPltm3tv/YBz9O8x2SPlCfHkAXhdxWd5opHyunf3DXxKkv/j7e/F+npE/V8/9Wrafo+jNyj55CHlXtDiF9mqW/6pRpU1LRJQPfHRFeFDJDOfIbxNk1sG38RT9fgaN6jH0eKzWCmPRMZKe/ZR8I0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788485467; c=relaxed/simple;
	bh=0/Ct6AIndNTvT6iAd+65ykN/F9WS8WuWsFrODtlpE0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhl/qWCl2CoE0WSTOCCyRyWqImH2Uc3iog6M8KFEZzxBFyuBkpSfIegIFfuoHVMLiDcpXG2HLZDjvEjmIqZrr4Ef1o50UZp6rfZEZy/qv6yXxaRl2pKPiiPCGvJytEv+OTFKQGTTthCGabgf518AE8Gwm7Y90GTKcVVLIg7qcxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xRAnTQeh; arc=none smtp.client-ip=91.218.175.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xRAnTQeh"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=0/Ct6AIndNTvT6iAd+65ykN/F9WS8WuWsFrODtlpE0c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788485463; v=1; x=1789090263;
 b=xRAnTQeho3jycMsqBwlLBJd76QBNKYLsWAfmtFtQxHCF4D/WTOeYQFBrvOZfdMY48PcCxpgQ
 9hI4Z1HfNIl3IctrC2YjiYLIxj0nzDVKcnP0j/A3A+NLUso2sEZ2KyrpTDwVkdiCRBy61vtja0j
 CQXrbqTDpkfTfb5uO2GqHOCQ=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e4f56eb3bad9c50f;
	Fri, 04 Sep 2026 01:31:03 +0000
X-Mizu-Trace-ID: e4f56eb3bad9c50f
X-Migadu-Flow: FLOW_OUT
Date: Fri, 4 Sep 2026 09:30:51 +0800
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
Message-ID: <apofS1ZRjnyIhCbk@fedora>
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

Ah, bond_update_slave_arr()... I only notice the bond_xdp_set_features() and
thought all the code after netdev_ops->ndo_bpf are xdp related...

My bad, I should check the code more carefully, and do testings even with
simple change.

Hangbin
