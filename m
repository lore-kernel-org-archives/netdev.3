Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792970078;
	b=c4unc+1GiurKyc877wcp14rKIOtG2FIiQwMVveBJAeoS4ymd63V8DmjyLmsGKWfplo9s
	 cFjNcNTVG5A2Z1Rb+mgqipAlqe6HGM9GFp+fBKdqwkP6BzKTIAIJbxKBzK2YGE5V37IxW
	 EeWpBNGjpPx4wTWDiOhxA2ndlAOSj8dn5jxER81ZJnWkt/cEj7tGrWiIQNAA/V8sys/GA
	 ZsOtB+yVUyzgLCTdGKwX8sXCN4yhutBkuGdSQnMIY1S35X3MI0Qa7k7tAJS9Df4MEdyIR
	 ux1Mh2umvo+c2ZqscgRk47g1CMVsXWRydBQuVVhd1V0CAY+egWZzREabsyhhJwDpcTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792970078;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=tQaes7bNYqS+ZJDcrEFv5Xvce1CpAz6+FFTd4+Au/aE=;
	b=Y/daZ6EXsWeoUGgLzTisuiOLC78stqCzC7VWMsGvrdHf2l2v2tNC8fifi1M151MgVfSM
	 XIjBuyH1zPbEkdu2BmwRYur4ua3kjqzk6AJGSrVkHC6tGt/1Ji8QinXQu5xVkZzMvdTV/
	 GRYE220aNSkbKFRWBZqSWSbxy/8msR58JA3iuq2xS0mDd/MCMI2w1D6CETrFIY94yEeyi
	 9S/+GRWJ0OD9GUx1NtaEVJiz2RIz/25H8URlXWzwQrmvS+oMfj5cYX7xHcjerZ8QerlzH
	 Pv/dAR4XiUSx9cJXV9Lk+txO0YJwDdzDmo4MeMr5TQzBSzv/ky7hsKBmiArQDL3ZzBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=BPRr55t8;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C602606A31A;
	Sun, 25 Oct 2026 23:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C602606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=BPRr55t8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tQaes7bNYqS+ZJDcrEFv5Xvce1CpAz6+FFTd4+Au/aE=; b=BPRr55t8hjrvM70KGh0K9OThhl
	pgGVr5QQZ7GfJhItI3GSzZn8qJu3QopA1vSd8qqnmOF7k2iv+CWLjJ6xAnx9fQgd8vDoaFBX52k39
	K4+HoQwpi+CjFbFHyNRkKsBpd3iYi9IbJam+uWeeFZCRSpP8X+6ethznfrLdBWzFsEio=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xL7Q3-00Cj0N-To; Mon, 26 Oct 2026 00:14:27 +0100
Date: Mon, 26 Oct 2026 00:14:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 1/2] net: dsa: mv88e6xxx: fix 88E6171 statistics
 snapshot
Message-ID: <404d5f2d-24a5-4edc-897b-b1b3c54a20e1@lunn.ch>
References: <20261024182124.296988-1-f.fainelli@gmail.com>
 <20261024182124.296988-2-f.fainelli@gmail.com>
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
In-Reply-To: <20261024182124.296988-2-f.fainelli@gmail.com>

On Sat, Oct 24, 2026 at 11:21:23AM -0700, Florian Fainelli wrote:
> The 88E6171 belongs to the 6351 family and takes the port number in the
> low bits of the statistics operation register. The 6320 snapshot helper
> instead encodes the port as (port + 1) << 5. On an EA4500, this causes
> ethtool -S to return physical port 0's MIB counters for every user port.
> Traffic on other ports does not update their reported hardware counters.
> 
> Before the snapshot operation was moved into the chip operations, only
> the 6320 and 6352 families used the shifted encoding. The refactoring
> incorrectly assigned that encoding to the 88E6171 as well.
> 
> Use the unshifted snapshot helper for the 88E6171. Tested on an EA4500:
> pings through different switch ports now update only the corresponding
> port's hardware counters.
> 
> Fixes: a605a0fe7115 ("net: dsa: mv88e6xxx: Abstract stats_snapshot into ops structure")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/net/dsa/mv88e6xxx/chip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
> index 7f68a0c55802..67daf3b9cb48 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> @@ -4610,7 +4610,7 @@ static const struct mv88e6xxx_ops mv88e6171_ops = {
>  	.port_disable_pri_override = mv88e6xxx_port_disable_pri_override,
>  	.port_get_cmode = mv88e6352_port_get_cmode,
>  	.port_setup_message_port = mv88e6xxx_setup_message_port,
> -	.stats_snapshot = mv88e6320_g1_stats_snapshot,
> +	.stats_snapshot = mv88e6xxx_g1_stats_snapshot,
>  	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
>  	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
>  	.stats_get_strings = mv88e6095_stats_get_strings,

static const struct mv88e6xxx_ops mv88e6171_ops = {
        /* MV88E6XXX_FAMILY_6351 */
...
        .stats_snapshot = mv88e6320_g1_stats_snapshot,

static const struct mv88e6xxx_ops mv88e6175_ops = {
        /* MV88E6XXX_FAMILY_6351 */
...
        .stats_snapshot = mv88e6320_g1_stats_snapshot,

static const struct mv88e6xxx_ops mv88e6350_ops = {
        /* MV88E6XXX_FAMILY_6351 */
...
        .stats_snapshot = mv88e6320_g1_stats_snapshot,

static const struct mv88e6xxx_ops mv88e6351_ops = {
        /* MV88E6XXX_FAMILY_6351 */
...
       .stats_snapshot = mv88e6320_g1_stats_snapshot,

Should these be changed as well?

Looking at DSDT:

static GT_STATUS statsCapture
(
    IN GT_QD_DEV            *dev,
    IN GT_U8             port,
    IN GT_U8             bank
)
...
    if (IS_IN_DEV_GROUP(dev,DEV_RMON_PORT_BITS))
    {
        portNum = (port + 1) << 5;
    }
    else
    {
        portNum = (GT_U16)port;
    }

and

#define DEV_RMON_PORT_BITS    \
        ( DEV_88E6065 | DEV_88E6065 | DEV_88E6352_FAMILY )

So your change looks correct, just not complete.

       Andrew
