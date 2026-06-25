Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25783E8321;
	Thu, 25 Jun 2026 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782401378; cv=none; b=KSeS05Y1JeC6dmwHcrXRNHCfa9bLJgsDHEHtzshuS3VFQiH3oMdK0L6NJen+MPFML5PQf/qI3ZPdwp4bHW9eVCkbLaEB3F3kc6FZhg6K9Lm1vW2FDfvXxW8C4ex3Bngz0ZD2DbIc1FmoW/rw5s9nZU4H9MH0cMuH+pOU0gyQFv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782401378; c=relaxed/simple;
	bh=9qnepkFYV8JpT0R+WCOwV/NO7C2ZhGyacdhokBHqAxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FrtN/4JWkEJFYOD2aVWJQkKBt91sDSmdJkMkGaEdfBieSESyAw7yBjIQDR2sRVVzivMzOD4deORe8r8C9wijAUp8MHKMBWxX8DOENIr0Yf62Uvt4rL7hw5wG0ZBzVj7K2mnghwmMOiaZUU/iDZpk1B2iM3yPAP7268qU5LMA0Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LUTqox/R; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LUTqox/R"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 561441A0996;
	Thu, 25 Jun 2026 15:29:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1406B5FF03;
	Thu, 25 Jun 2026 15:29:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 84DEE104C8392;
	Thu, 25 Jun 2026 17:29:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782401372; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=4Viu3OpkamDZjnNOfz+R+bFCVzP7fjIDEzbr6zL3TWI=;
	b=LUTqox/RCvwCVLBjaXIWJfnO1G7LKJSBYExR7PiTQh10Un5gstEMJhnAQkggDUnXFMNras
	A31yvKQDR6wju4jFRVszG03x4B/VlPiKKDFFuW3qxT7260ycDbBf6GaG6Yuij1EF4j5D7z
	Yv9RHjXvsZ+pvSgg9w9yEx2f8fHVujGxuvLJiF2QbCCFzT7CaIN0GIn9g6tgHL/uKJCH07
	+C1W+gABl80mTzH33tHI4C0YrxsXt6LcUhkhk0Y5XPKr/SJCRChajfPv0vGosehAayOHxa
	gdrpNxbcaFSs/zmrhOZFMB3jhQAj+3o5H4zI7tkhl/KW2oN67fXjCHzurTfCnw==
Message-ID: <38bafe7e-d419-46f7-8fa7-87e9183e578c@bootlin.com>
Date: Thu, 25 Jun 2026 17:29:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] Documentation: networking: Add a test plan for
 ethtool pause validation
To: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Florian Fainelli <f.fainelli@gmail.com>, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20260522175109.198059-1-maxime.chevallier@bootlin.com>
 <20260526172447.10ca4b9e@kernel.org>
 <5cb8e2b4-8eb6-4446-9b90-1cd4c7964cd9@lunn.ch>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <5cb8e2b4-8eb6-4446-9b90-1cd4c7964cd9@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Andrew,

On 5/27/26 04:47, Andrew Lunn wrote:
> On Tue, May 26, 2026 at 05:24:47PM -0700, Jakub Kicinski wrote:
>> On Fri, 22 May 2026 19:51:06 +0200 Maxime Chevallier (Netdev
>> Foundation) wrote:
>>>  Documentation/networking/pause_test_plan.rst | 556 +++++++++++++++++++
>>
>> It'd be great to hear from others but IMHO in the current form this is
>> not suitable for Documentation/networking/ We can commit the "knowledge"
>> part but enumerating the test cases seems odd for Documentation/.
> 
> Sorry, not looked too deeply at the actual content yet.
> 
> What i was thinking was a python file, which sphinx can ingest to
> produce documentation, and place holders were code would be added to
> implement the actual test during the next phase.
> 
> This is how i've done testing in the past. I would be the evil one who
> thought up the tests and described them in detail using sphinx markup
> in a python test template file. After some review they got passed off
> to a python developer for implementation. And when they got run and
> failed, sometimes the feature developer, the test developer and myself
> got together to figure who made the error.
> 
> I'm not sure we even need sphinx. What i find important is that the
> test is documented. What kAPI calls should be made with what
> parameters. What results we are expected and why? So that when a test
> fails, a developer has the information they need to fix their
> code. The Why? is important, and often missing from the kernel tests.

This isn't sphynx, but I've come-up with something like this for a
test definition :


@ksft_ethtool_needs_supported_anyof([Pause, Asym_Pause])
def test_ethtool_pause_advertising(cfg, peer) -> None:
    """Pause advertisement

    Validate that changing pause params through the ETHTOOL_MSG_PAUSE command
    translates to a change in the advertised pause params, and that these
    parameters are correct w.r.t the supported pause params and requested pause
    params.
    
    This exercises the .set_pauseparams() ethtool ops for MAC configuration,
    as well as the reconfiguration of the PHY's advertising and negociation.
    
    On non-phylink MACs, the MAC should call phy_set_sym_pause() to update the
    PHY's advertising, and restart a negotiation with phy_start_aneg() if
    need be. Failure to do so will result on the wrong advertising parameters.
    
    Pn phylink-enabled MACs, phylink deals with the PHY reconfiguration provided
    the MAC driver calls phylink_ethtool_set_pauseparam().
    
    Failing this test likely means that the PHY driver is not correctly advertising
    pause settings, either due to the MAC not triggering a PHY reconfiguration,
    a misconficonfiguration of the advertising registers by the PHY, or by
    mis-handling the phydev->advertising bitfield in the PHY driver directly.
    
    The validation is made by looking at the advertised modes locally, as well as
    what the peer's 'lp_advertising' values report.

    cfg -- local device's interface configuration
    peer -- peer device handle
    """

    # Initial conditions :
    # - Local interface is admin UP, and reports lowlayer link UP
    # - Remote interface is adming UP, and reports lowlayer link UP
    #
    # Test 1
    # - SKIP if supported doesn't contain "Pause"
    # - run 'ethtool -A ethX rx on tx on autoneg on'
    # - FAIL if the return isn't 0
    # - FAIL if ETHTOOL_A_LINKMODES_OURS's advertised values does not contain
    #   "Pause" or contains "Asym_Pause"
    # - FAIL if peer's lp_advertising doesn't contain "Pause" or contains
    #   "Asym_Pause"
    # - Succeed otherwise
    #
    # Test 2
    # - SKIP uif supported doesn't contain both "Pause" and "Asym_Pause"
    # - run 'ethtool -A ethX rx on tx on autoneg on'
    # - FAIL if the return isn't 0
    # - FAIL if ETHTOOL_A_LINKMODES_OURS's advertised values does not contain
    #   "Pause" or contains "Asym_Pause"
    # - FAIL if peer's lp_advertising doesn't contain "Pause" or contains
    #   "Asym_Pause"
    #
    # ...
   
The annotation defines the pre-requisites in terms of locally supported
linkmodes, we have a docstring containing information for developpers
to debug their drivers, what I'm unsure about is the commented-out part
below, so either one big function testing multiple adjacent scenarios
or indivitual functions.

We could also use annotations to enumerate the various combinations of
modes to test.

That's just an extract of the full test suite for Pause, but before
writing the whole thing down i figure it's better to iterate on a single
test's design.

What do you think ?

Maxime
