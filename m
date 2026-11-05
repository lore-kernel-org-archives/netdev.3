Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.60
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793861026;
	b=4b+TLnMOAJTavmHRXt6m/7Eay0eYeSuEBv7Rk5H33SCs8vB47QmMnj5QNJXUZTzS+i5g
	 G64430B7AjnoXCfA23iTU7pbx0UQIH0vgwJFrvc3pwfCS9qrtMvp9I43hnvsPuZHrwi7t
	 zRPA4TbWUlLbobghHwIkC8Vrj3HNH89MJt6oW43n8ZAR2A5iZN2gg2JNHiCoDNkXHHP9+
	 cnGioIcHZyqlW7hiXQk8nAp4spdlGq+XGvWeyjro7pc9k8EOoKtljDvbSaQdoJ8jo3v6n
	 TUN8VxuIeUvJK5oF/AYxAxfcc/CzY1aGUNKCtZKN1CmCe72Y2vnBqtoqRTTsQE1Ci2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793861026;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=VLLZjXMmTQmjz6A0S5RDZnlHH5IW/gvBf0f/hTwSx+Q=;
	b=okgKCOn/D4aLuupaokGPcWK7knragPwo0Y0nRJsZHieY2vQiwCvUy5B2CmKcDPw+dAGJ
	 d/csW29JePGQmFIT6ACzJszRggjC8vVQXxD2Us4PdYfhZax/4KxxYbp0tkffYa7bCrLP6
	 hJvw7NICtneEG2bmXLFLFUhfrkoQENYRWYGiWq4qj4SZOLbx4DI6SeebNkYsvaRwrUBmH
	 83teFF4TfmL3MPek78TAEG4SX7vfPSREUPGOKHKXO/ZV7luy2iCJObxU2n8MrqIFRPk2W
	 YEQWNdCE1luj89vNs/KKhbeYsmfMMKQHAXjyoTFXeRKcyk3hdehtGDAoKfEVyuY25EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fC+Hj71n;
	arc=none smtp.remote-ip=95.215.58.60
Received: from mta1.migadu.com (out-60.mta1.migadu.com [95.215.58.60])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8E6606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 06:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D8E6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fC+Hj71n
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=TWkp5Lnn5QB+qibeKwukcrGkB96ZSbaKyvgbcrCA0z0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793861021; v=1; x=1794465821;
 b=fC+Hj71ncWojl71Daqrz/5OaXJX3HCELYMzXX8uXr3k751MjM1IUXeOQMvo3pQmrUP8RBDK4
 /zxN2Lrz0Jjekch9UC7Gx6oYObmxCkBQM25+Ou+1pm2GB1WJR1fS73lsOoXZTLSbPvU7Df38ikJ
 6jK9U4t8jhq5Z62kE5V2QinE=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 868ae7c57c796658;
	Thu, 05 Nov 2026 06:43:41 +0000
X-Mizu-Trace-ID: 868ae7c57c796658
X-Migadu-Flow: FLOW_OUT
Date: Thu, 5 Nov 2026 14:43:27 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Timur Stukan <timur.stukan.linux@gmail.com>
Cc: netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jarod Wilson <jarod@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] bonding: 3ad: don't set BOND_LINK_FAIL on a slave
 that is not up
Message-ID: <auwlgjeIsjStlUnd@fedora>
References: <20261101145653.63648-1-timur.stukan.linux@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261101145653.63648-1-timur.stukan.linux@gmail.com>

On Sun, Nov 01, 2026 at 04:56:53PM +0200, Timur Stukan wrote:
> In 802.3ad mode, when bond_update_speed_duplex() fails on NETDEV_UP or
> NETDEV_CHANGE, bond_slave_netdev_event() sets the slave link to FAIL if
> the slave has ever been up (last_link_up != 0), and to DOWN otherwise,
> so that miimon can set it right once speed/duplex are valid.
> 
> last_link_up is never cleared, so a slave that is currently DOWN but
> was up before is set to FAIL as well. miimon then treats it as a slave
> that is still in use and takes it through the full down path again:
> the link failure count is incremented, "link status definitely down"
> is logged and the 802.3ad port is disabled a second time, although the
> slave has not been up since it went down.
> 
> Reproduced in 802.3ad mode with miimon=100 by setting a slave down and
> up again. On NETDEV_UP the speed is still unknown, so the notifier sets
> FAIL, and the next miimon pass sees no carrier and proposes DOWN:
> 
> 	ip link add bond0 type bond mode 802.3ad miimon 100 lacp_rate 1
> 	ip link set enp0s3 down
> 	ip link set enp0s4 down
> 	ip link set enp0s3 master bond0
> 	ip link set enp0s4 master bond0
> 	ip link set enp0s3 up
> 	ip link set enp0s4 up
> 	ip link set bond0 up
> 	# wait for LACP to settle
> 	ip link set enp0s3 down
> 	ip link set enp0s3 up
> 
> procfs then shows "Link Failure Count: 2" in enp0s3 slave part. Also in
> dmesg wrote twice: "link status definitely down, disabling slave".
> 
> Fix this by setting FAIL only for a slave that is currently UP and
> leaving other states alone. An up slave that loses speed/duplex still
> goes through FAIL as before, and DOWN/BACK slaves are left to miimon,
> as in the other modes.
> 
> Fixes: ea53abfab960 ("bonding/802.3ad: fix link_failure_count tracking")
> Signed-off-by: Timur Stukan <timur.stukan.linux@gmail.com>
> ---
>  drivers/net/bonding/bond_main.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 7019e5d8fdc8..8212d406f3bc 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -3973,18 +3973,13 @@ static int bond_slave_netdev_event(unsigned long event,
>  	case NETDEV_CHANGE:
>  		/* For 802.3ad mode only:
>  		 * Getting invalid Speed/Duplex values here will put slave
> -		 * in weird state. Mark it as link-fail if the link was
> -		 * previously up or link-down if it hasn't yet come up, and
> -		 * let link-monitoring (miimon) set it right when correct
> -		 * speeds/duplex are available.
> +		 * in weird state. Mark an up slave as link-fail and let
> +		 * miimon set it right when correct speed/duplex are available.
>  		 */
>  		if (bond_update_speed_duplex(slave) &&
> -		    BOND_MODE(bond) == BOND_MODE_8023AD) {
> -			if (slave->last_link_up)
> -				slave->link = BOND_LINK_FAIL;
> -			else
> -				slave->link = BOND_LINK_DOWN;
> -		}
> +		    BOND_MODE(bond) == BOND_MODE_8023AD &&
> +		    slave->link == BOND_LINK_UP)
> +			slave->link = BOND_LINK_FAIL;
>  
>  		if (BOND_MODE(bond) == BOND_MODE_8023AD)
>  			bond_3ad_adapter_speed_duplex_changed(slave);
> -- 
> 2.43.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
