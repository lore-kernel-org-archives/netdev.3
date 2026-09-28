Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02472474261
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 08:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585075; cv=none; b=qgfyz8LUKm6WL5gIiL2CMT9ENWoNbGPHW4DLEob2rFahlIQ4lGfiRqDYYKNLQX0869Q+DlNE+Eu4JYiJSxSonCZs7+Fpg4QqjZBqxawTPUTCVlYU4cxDSTAUEY++Pz6ZwvpjKnxJhB6Ug0/dujvlhX1Y8iJfabYvtTdBI3aZHS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585075; c=relaxed/simple;
	bh=tXzrfQ3Fk8jK4BlEPTK1UmMOMRhhbVRgMoaq5IM1RZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WVocbxfAvy3fWMun4+OkMRl5oTiLMHsKUtVsewtwMff27xkW+SBqVPlATFS6Um6CYBe1eIkb/iLiHgjxGJaeu3obm86uwSu5Q58JtlHPqISyeB/hPGuOtXL/tICFyM0QxFrRgybrwcp6HHuqU3z6UDrYWRCLdH1WFSruRGjDSQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phrozen.org; spf=pass smtp.mailfrom=phrozen.org; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phrozen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phrozen.org
Received: from [2a04:4540:1402:f1fc:e4ac:7bd9:3fdf:bca3]
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <john@phrozen.org>)
	id 1xB6ru-00C7sF-0s;
	Mon, 28 Sep 2026 10:37:50 +0200
Message-ID: <0077ab02-2215-4015-9e74-eeb8c3de6b14@phrozen.org>
Date: Mon, 28 Sep 2026 10:37:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] net: towards a generic PON framework
To: Andrew Lunn <andrew@lunn.ch>
Cc: Ziyou Xu <xuziyougm@gmail.com>, netdev@vger.kernel.org,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King <linux@armlinux.org.uk>, Gaoyang Wei <yhyxwgy@gmail.com>
References: <20260926174601.1675-1-yhyxwgy@gmail.com>
 <b0d1908c-a6f6-4c28-bb4f-b00644acacfc@lunn.ch>
 <92d9c8a9-ef43-45ce-a599-2c00d0a2fa61@gmail.com>
 <3d5e9f9f-09e0-41a2-aa3a-e3bcfcecbef3@lunn.ch>
 <7a469037-1266-4ca3-904b-9e8117cce5e9@gmail.com>
 <e17ad80f-f2f8-4776-9f8b-1b7d3407c438@lunn.ch>
 <86e368cd-9f5a-49cb-a798-0f26a661fc30@gmail.com>
 <372bc103-e98f-486d-8dd2-f013b1dbbdcb@lunn.ch>
Content-Language: en-GB
From: John Crispin <john@phrozen.org>
In-Reply-To: <372bc103-e98f-486d-8dd2-f013b1dbbdcb@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi all,

Christian Marangi has been working on the design of a PON subsystem
together with Airoha for almost a year. I started implementing it on
the AN7581 two months ago. Reading this thread was a bit of a
surprise, because the design you are converging on is very close to
what we already have running and were planning to propose upstream in
the near future. So rather than add another design on paper, let me
describe working code.

The design is modelled on nl80211/cfg80211 with a fullmac driver.

net/pon has a struct pon_dev for each PON MAC. It is not a netdev,
which is what Andrew described with the wiphy comparison. Userspace
talks to it by a device id, not an ifindex.

The MAC driver runs PLOAM and the key hierarchy itself, as Benjamin
suggests. It reports the activation state to the core. The core checks
it, publishes it together with the alarms and sets carrier from it.

Service traffic uses normal netdevs. There is one data netdev, plus
GEM netdevs where a GEM port needs its own bridge port. Frames leave
through a GDM port of the Ethernet driver, which acts as a conduit in
the DSA sense.

Andrew's mapper exists too. A classifier on the data netdev maps
VLAN and 802.1p to GEM ports. The core keeps the T-CONTs, the GEM
ports and these rules. It replays them after a link loss. Everything
above that is plain bridge, VLAN devices and tc. T-CONT scheduling is
an offloaded ets qdisc.

The design reuses existing infrastructure wherever it can. The optics
report through hwmon and take their calibration from NVMEM. The PON
serdes is a generic PHY. The PHY core only needed a PHY_MODE_PON and a
set of PON configure options. Sync status, FEC counters and three
reports (ready, loss, TX fault) go through a small PON side channel.
That could become part of the PHY core, but that is a problem for
another day.

Control is a single generic netlink family with a YAML spec. OMCI runs
in userspace, in a GPL daemon that sets up the PON objects over that
family and everything Ethernet over bridge, tc, ethtool and rtnetlink.

There is also a small command line tool, pon-tool, which plays the
role iw plays for nl80211. It has a verb for every attribute of the
family, so the whole subsystem can be inspected and driven by hand.
It dumps the device, T-CONTs, GEM ports, classifier rules, counters
and alarms. A monitor mode follows the PLOAM state, alarms and object
changes live. GEM netdevs are created over rtnetlink with their own
link kind, the same way iw creates wireless interfaces.

The current code reaches O5, passes traffic and survives fibre pulls
against a production OLT. I have successfully tested HGU, SFU and IP
host services running concurrently. PON flows are also offloaded in
hardware through the Airoha PPE and NPU.

On the OMCI transport I think Andrew is right that omci0 has to go.
Today it is an ARPHRD_NONE conduit used with AF_PACKET, which is an
interface that is not really an interface. Rather than add a new
address family, I would follow what hostapd and wpa_supplicant do.
Wifi once relied on a monitor interface for management frames. It
moved to frame registration, TX and RX over generic netlink. The PON
family would get the same: a daemon registers for OMCI on a PON
device and receives and sends PDUs as netlink messages. That keeps
the subsystem on the design that already works for wifi and needs no
new address family. The core already knows which GEM port carries
the OMCC, so there is nothing to classify.

Benjamin, you wrote that some parts of the MIB should be handled
inside the kernel. Which MEs do you have in mind? The OMCC transport
belongs to the core, so an in-kernel handler could attach to it. I
would like to understand which MEs need it before we design for it.

If all of this sounds plausible, I can post an RFC series of the
subsystem within a week, together with a link to a git repository
with pon-tool. Before that I want to move the OMCI transport to
generic netlink and validate it on a board.

	John


On 28.09.26 03:25, Andrew Lunn wrote:
> On Mon, Sep 28, 2026 at 07:11:19AM +0800, Gaoyang Wei wrote:
>> Hi Andrew,
>>
>>> Another question which might affect the architecture. From what you
>>> have described, an ONU might be assigned multiple Port-IDs so it can
>>> carry multiple, separated, service traffic streams? You would want to
>>> represent each stream as a Linux netdev, with its own IP addresses
>>> etc.
>>
>> An ONU can indeed have multiple GEM Port-IDs, but I think there is one
>> important distinction here: a GEM Port-ID is not necessarily equivalent
>> to one Linux service interface.
>>
>> G.988 has an interworking layer between the GEM connections and the
>> Ethernet-facing service.
>>
>> For example, one Ethernet UNI can use an IEEE 802.1p mapper which sends
>> different priority classes to different GEM ports.  Bridge and VLAN
>> configuration can also make the relationship between Ethernet services
>> and GEM connections non-1:1.
>>
>> Very roughly:
>>
>>                       Ethernet UNI
>>                            |
>>                    bridge / mapper /
>>                      VLAN handling
>>                      /     |     \
>>                     /      |      \
>>               GEM port  GEM port  GEM port
>>                  100       101       102
> 
> I think that is too roughly, because that is not how Linux actually
> works.
> 
> A normal setup would be
> 
>                  br0
>                   | 
> 		Bridge
> 		|    |
>                eth0 eth1
> 
> and
> 
> 	vlan0:42
> 	 |
> 	 eth0
> 
> What it sounds like it should be is
> 
> 
>                  br0
>                   | 
> 		Bridge
> 		|    |
>                eth0 eth1
>                 |    
>        ------mapper------
>       /        |         \ 
>     GEM port  GEM port  GEM port
>        100       101       102
> 
> You get your 802.1p tagged frames flowing down from user space and at
> the bottom you map them to GEM ports.
> 
> How you classify frames above to tag them for 802.1p should be out of
> scope at this level, it is a TC problem, or done via the VLAN
> interfaces stacked on top of the base interface. It is a solved
> problem Linux can already do. It is the mapper which is new.
> 
> But i assume this is also possible:
> 
> 
>                eth0                                 eth1		
>                 |    		                     |    		
>        ------mapper------	            ------mapper------		
>       /        |         \ 	           /        |         \ 	
>     GEM port  GEM port  GEM port         GEM port  GEM port  GEM port
>        100       101       102              103       104       105  
> 
> 
>> Putting your two suggestions together seems to lead to a cleaner model:
>>
>>                      +------------------+
>>                      |    PON device    |
>>                      |  (wiphy-like)    |
>>                      +--------+---------+
>>                               |
>>                 +-------------+-------------+
>>                 |                           |
>>              AF_OMCI                 service interfaces
>>                 |                           |
>>           OMCI userspace             Linux net_device(s)
>>                                             |
>>                                    VLAN / TC / bridge
>>                                             |
>>                                       GEM mapping
> 
> You might want to talk to the wifi developers. Do they actually like
> the wiphy model, does it work for them, or do they wish they could
> throw it away and start again? What would they do differently?
> 
>> That also seems to answer part of the question raised by your AF_OMCI
>> idea.
>>
>> If OMCI is a protocol associated with this lower-level PON object,
>> then there is no need for a synthetic omci0 merely to obtain
>> AF_PACKET semantics.
> 
> So as you say, one question is, how do you associate an AF_OMCI socket
> to the lower level PON object? A typically home router probably has a
> single SFP cage, but maybe somebody will build a box with two SFP
> cages, you can connect to two independent providers so you have
> redundancy, and load balancing, etc.
> 
> How does addressing work at this level? BSD Sockets can use bind(1) to
> set the local address. Or you have SO_BINDTODEVICE socket option, if
> there is a name which can be used. I don't think it needs an ifindex.
> 
> 	Andrew
> 
> 

