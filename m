Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=121.127.44.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793576501;
	b=axmEuU/Wa8p0jeUyi2fnFWZxfmCuhVjH0scaFvlcpvrJK4+cWihAgKUBN92jPyG1pZTi
	 2BeVW7ofNdqUWRzJiuqagkrrKb/NunHPMN2FK1ypOCh66zEMgpQevhHcXKdQfmgW/fPB8
	 jaRYTBsjtyJMS/AXMXXuX3/4mb3+iZCSa1NKNd94kJcPUkNIFJcHcLEn/nMo/VBQ8KL2l
	 8NDsvux1v6p0KCvaumbxASZTfay+bo48d35tpOaoCj8wsQt79Mj3u4GnQUZSez6ELjlUi
	 n1YSZS5U3xaObYZ0GMRR+ooCpmo2GThF4HXoDtM9jAyDUzAgOVmjiyq3f0vsKBeQdDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793576501;
	h=DMARC-Filter:DKIM-Signature:X-Forward-Email-ID:
	 X-Forward-Email-Sender:X-Forward-Email-Version:
	 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
	 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=ypPd9unCPRKnmOOEGLs6Sx0KOiFfY8/EXgl2Ea6FLkQ=;
	b=HaRoOO3v4iHhIWaBWCgNgKlj/kjf+bobYhzsa8anEZnycgYR7TWmlgTa0aKVFtAKAhEl
	 qI3ZI40wiz9l34+IWjFMDzMWijOxWaaL2KjVzZRvNqVhlpJOpK2a3Vnz5XeS6TTtH1jRY
	 VuantCp+tPLJQ+6qQ1rtovRA3K9gPlXRf3dARxXuiH997x9kS7SNw1FteAxYndafvc2j0
	 4EvNyC1QGXWKzZxvWHyt/uxQELI8xRKKC/XizmXTU8DghjVe0q2vQKKFsoJo1KF2rDPS1
	 BOhBHEp+fGTym8SxRBNO5yY6GNHEe7gOgdF75yX3sTw2xXssmWfNu4QmbS0Vzzl8+Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ovn.org;
	spf=pass smtp.mailfrom=fe-bounces.ovn.org;
	dkim=pass header.d=ovn.org header.i=@ovn.org header.a=rsa-sha256 header.s=fe-13eddc7e57 header.b=HCZPgsqk;
	arc=none smtp.remote-ip=121.127.44.66
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FF3606A324
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 23:41:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09FF3606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ovn.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ovn.org header.i=@ovn.org header.a=rsa-sha256 header.s=fe-13eddc7e57 header.b=HCZPgsqk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ovn.org;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-13eddc7e57; t=1793576494;
 bh=ypPd9unCPRKnmOOEGLs6Sx0KOiFfY8/EXgl2Ea6FLkQ=;
 b=HCZPgsqk+SKy/PaSf5N7gs+PdGc1kmge6u4UdCPh93hIiurbNRRxXzKHx0KGGTglzaY34wsAl
 ykOEfPFLc/HI6TXaaomvgtxqQhzsfvfTHe3Cn+JETsZfc1hQOux8cJs1gPVIYU9+I4vbinybhm5
 R8kdmcq83igDzLNrC+lNUPk=
X-Forward-Email-ID: 6ae7ce297155658d66b80d68
X-Forward-Email-Sender: rfc822; i.maximets@ovn.org, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.18.12
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <c4c0c187-1c8b-49ab-978a-815c599b4b4c@ovn.org>
Date: Mon, 2 Nov 2026 00:41:24 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] openvswitch: advance by the real header length in
 get_ipv6_ext_hdrs()
To: Joas Antonio dos Santos <joasantonio108@gmail.com>,
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, dev@openvswitch.org, linux-kernel@vger.kernel.org
References: <179328922134.76862.10417963652853801970@gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <179328922134.76862.10417963652853801970@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/26 4:53 PM, Joas Antonio dos Santos wrote:
> get_ipv6_ext_hdrs() walks the IPv6 extension header chain to fill
> key->ipv6.exthdrs, but advances to the next header with ipv6_optlen()
> whatever the current header is.  That is only right for Hop-by-Hop,
> Destination Options and Routing headers:
> 
>  - an Authentication Header is ((hdrlen + 2) << 2) bytes long
>    (ipv6_authlen()), so with hdrlen = 4 the walk skips 40 bytes instead
>    of 24 and reads the next "header" from the ICV and payload;
> 
>  - a Fragment header is always 8 bytes, and the byte read as hdrlen is
>    its Reserved field, which the sender controls and receivers ignore,
>    so a non-zero value makes the walk skip up to 2048 bytes and miss
>    the headers that follow.
> 
> In both cases the OFPIEH12_* bits stored in key->ipv6.exthdrs depend on
> bytes chosen by the sender rather than on the headers that are actually
> present: payload bytes that look like another AH or a Hop-by-Hop header
> add OFPIEH12_UNREP/OFPIEH12_UNSEQ, and real headers after a Fragment
> header can go unreported.  Flows that match on OVS_KEY_ATTR_IPV6_EXTHDRS
> then classify such packets wrongly.  There is no memory safety issue,
> skb_header_pointer() bounds every read.
> 
> Advance by sizeof(struct frag_hdr) for Fragment headers and by
> ipv6_authlen() for AH, as ipv6_find_hdr() does.
> 
> Fixes: 28a3f0601727 ("net: openvswitch: IPv6: Add IPv6 extension header support")
> Link: https://lore.kernel.org/all/178905555085.219967.6617611783437228045@kernel.org/
> Cc: stable@vger.kernel.org
> Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
> Assisted-by: Yaga Agent HackerSec Claude:claude-opus-5-5

The tag is no longer needed.  And it has a wrong format anyway.

> ---
> Found while going through the pre-existing issues the Sashiko review of
> "openvswitch: fix wrong flag value in get_ipv6_ext_hdrs()" pointed out
> (Link above); Eelco mentioned putting them on his todo list, and I did
> not find a fix for this part in net, net-next or on the list.  Happy to
> drop this if a fix is already in flight.
> 
> Tested by building get_ipv6_ext_hdrs() before and after this patch in a
> userspace harness (skb_header_pointer() replaced by a bounds-checked
> memcpy from a buffer) and feeding it crafted packets:
> 
>   AH(hdrlen=4) + DSTOPTS + TCP, payload mimicking AH at old offset
>     before: AUTH DEST UNREP UNSEQ      after: AUTH DEST UNSEQ
>   FRAG(Reserved=0xff) + DSTOPTS + ROUTING + TCP
>     before: DEST FRAG UNSEQ            after: DEST FRAG ROUTER UNSEQ
>   FRAG(Reserved=0) + ROUTING + TCP, HOP + DST + ROUTING + TCP
>     unchanged
> 
> net/openvswitch/ builds cleanly with W=1 (arm64, net/main 94cea342e891).
> I did not test it on a live datapath.
> 
>  net/openvswitch/flow.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
> index 1c4f3a079..a1c60d2f5 100644
> --- a/net/openvswitch/flow.c
> +++ b/net/openvswitch/flow.c
> @@ -372,8 +372,13 @@ static void get_ipv6_ext_hdrs(struct sk_buff *skb, struct ipv6hdr *nh,
>  		hp = skb_header_pointer(skb, start, sizeof(_hdr), &_hdr);
>  		if (!hp)
>  			break;
> +		if (next_type == IPPROTO_FRAGMENT)
> +			start += sizeof(struct frag_hdr);

Should we also stop it's not a first fragment?  There is no actual
next header after the fragment one if it's not the first.  Otherwise,
the patch seems incomplete.

Best regards, Ilya Maximets.
