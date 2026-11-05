Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793917246;
	b=BPeIGyzBVF5/ZDD7yg5GPXXMNc0AiO7KhsmfJXTY3LW+YPqVFJw1VtBKTTUbVVmLGLzg
	 cCjMw9tzq2T2DrPTPhFAJmHU08UPVJPcZLJz7dVSezQFYoy/v/ExtC/NAl+Qb30dgfq8+
	 cjaOgm8IKD7eOuq28BHNJwh35KDcPKkM0RL5Wy5qu8Kfr/w8uvbO4IJ6Epb0XLsdeSmr2
	 QXF/6torTBPMWRCdie8l1iIG4AYQmB8zr4vDrlpos4vSmkBhZn5rW0IKm2xqBjzHzy51n
	 ktadzmmoACfJ5H+jS/NUN9upXB6+6J1S6s5ZKPa3ugExk2iUSxJGlNmYqEoUx2vdPng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793917246;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=fJJlCMoNQLt0YAspu0FY49lYMN1jzY5kSPkVivJbaXk=;
	b=AEpOUVGkygmFR0QpAUx6Emq9QeZ54ZVS6bLIxZ1CQ6w6aBSwE6mPQGhJ8f6u2lAg26wf
	 xX7gYy30HxMXORXcwGWQiKkgSGQGzmeVe/aoLZDoYhsSGl2ONiCVlzDHkzwTIySfycmNw
	 vkbaDIQBY1fCwNcsF4PD5sI/ABZUCi0WhjAIMVVn+EvQkiaHNK4jbrW7OvPNTF7Ovx5Gk
	 rAdijLKHXZ0F922Uy76ClH9jZgO0UGiaa2cYgh48uhB2to8kN6yatEsFDhyr1pvH1cO0d
	 9q1swogcmhiG2ke3WE3OzIf47BogEQhJNOTLxLA2eLyADKSg9O9XRFCo1sehMECw22g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Ql9d55NN;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7FA606A31B;
	Thu,  5 Nov 2026 22:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD7FA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Ql9d55NN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fJJlCMoNQLt0YAspu0FY49lYMN1jzY5kSPkVivJbaXk=; b=Ql9d55NNEnSRMqwx3Z1hogRDKW
	x6RGfbD1aFt6VCaX8qZj7bFKQOzHPu4ui0GKI3t08sMPphSYemFjBUtCTF97Fu2KA9PROQZ9fTXLh
	7MzNN3zPpDknrLxNVAu0T0MbfFz9guFJiRS8YutTidS2GryHxWT0Dys8MsLnpDqf/sz0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xP5oz-00Ee66-1U; Thu, 05 Nov 2026 23:20:37 +0100
Date: Thu, 5 Nov 2026 23:20:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/4] net: dsa: motorcomm: Fix extack message on
 unsupported TC actions
Message-ID: <a1d44a84-d180-407f-b312-ef29eeaeecd5@lunn.ch>
References: <20261102071119.3435180-1-mmyangfl@gmail.com>
 <20261102071119.3435180-2-mmyangfl@gmail.com>
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
In-Reply-To: <20261102071119.3435180-2-mmyangfl@gmail.com>

On Mon, Nov 02, 2026 at 03:11:13PM +0800, David Yang wrote:
> No extack reasons were given to unsupported TC actions. Fix it.
> 
> Fixes: 8eb9e7520b17 ("net: dsa: yt921x: Add ACL support")
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  drivers/net/dsa/motorcomm/tc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/dsa/motorcomm/tc.c b/drivers/net/dsa/motorcomm/tc.c
> index 9dbd61e48fee..8835907366bf 100644
> --- a/drivers/net/dsa/motorcomm/tc.c
> +++ b/drivers/net/dsa/motorcomm/tc.c
> @@ -1122,6 +1122,7 @@ yt921x_acl_rule_ext_parse_flow_action(struct yt921x_acl_rule_ext *ruleext,
>  			break;
>  		}
>  		default:
> +			reason = "Unsupported by HW";
>  fallback:
>  			if (cls->common.skip_sw) {
>  				NL_SET_ERR_MSG_FMT_MOD(extack,

Maybe also change:

const char *reason = NULL;

to

const char *reason;

That way, the compiler is likely to warn you if reason is used but not
set.

	Andrew
