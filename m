Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794453270;
	b=YqTkQrCoBOU6nJlsBfbdYOvK0c0ILMpyutTPtTpgEIqCPxIR+JHUikp3YXANd0GUxzUD
	 ZxPFwVpsEtlVTRMjtFy3HWM2HhdOKbMCPuvgTGiMWGHQrVoKuHyiZIPWURyoSId1rbYak
	 s/LF8TJ1I59e+BPofuMdKgjpTYdaFBU1KJRr3lHQH6+hVXQ4Yz9uT5ARqgO/ikye7gSHA
	 v90tt7gXKVjeaS3RnIkTfPd/np3acixL2Ta3JsGVWlyxWrE3NBnKZztIMozz2xnimheB8
	 mYZHnryL4V6FbMO2bCY0BZavceN7yhOj8lZHtQSrXadK9mPcq5jtwhqRhrJvxdD/rYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453270;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:X-CID-META:
	 X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=FdF+h7AtULUUrmxiUaxhZy1q0/4wai1urbrPTsOyOSQ=;
	b=IMUXNLrXHbBKaEx4G5yx/DyEhkhXLRxzq6/tQx06aU8oU4Fce+GxHPKQrsPMBE1AfAqv
	 ziI80icfahNwakA2kN7VjlGRwxqcekYseKzyzcXMmB3+r/JpEb8ppeUhsHwOW5EoZwNU9
	 IY+ckjjxU/c6SJPUwcu5bc9NgHo6pbuG/ks3az8BOR8m+UzPPZf3VIlcKwKuMTE/g7vRx
	 jqokQwYu7+86yGgSV1dAxqRooNLOGC3BPw1lpP/p+O/GADvYjaNSgD4EfiPAvnAZMEzCq
	 l65ItR+s2sjVSRDxEbEScwmL9o6plQA+/UhtqTtw6svWawQZjJOx1qzBj8ZyIOAPGAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B5A606A31C;
	Thu, 12 Nov 2026 03:14:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7B5A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 29bc072cde4711f19a56ed5b684f684d-20261112
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:dec4d389-e4f5-4a5a-937a-833c6fb048fd,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:7,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:17
X-CID-INFO: VERSION:1.3.19,REQID:dec4d389-e4f5-4a5a-937a-833c6fb048fd,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:7,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:17
X-CID-META: VersionHash:7db8b62,CLOUDID:a5b1225bd12cb549e5de2b1449ab6336,BulkI
	D:261112101701HAGG4G4K,BulkQuantity:1,SF:17|19|64|66|78|80|81|82|83|102|12
	7|136|153|841|865|898,TC:nil,Content:0|15|50|99,EDM:-3|-100,IP:-2,URL:99|1
	,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:N
	O,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 29bc072cde4711f19a56ed5b684f684d-20261112
X-User: liuhangbin@kylinos.cn
Received: from fedora [(114.244.3.119)] by mailgw.kylinos.cn
	(envelope-from <liuhangbin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1826982388; Thu, 12 Nov 2026 11:14:24 +0800
Date: Thu, 12 Nov 2026 11:14:22 +0800
From: Hangbin Liu <liuhangbin@kylinos.cn>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Wessel Jacobi <wessel@jacobi.pw>, linux-doc@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Hangbin Liu <hangbin.liu@linux.dev>,
	Linux Networking <netdev@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yuyang Huang <sigefriedhyy@gmail.com>,
	Donald Hunter <donald.hunter@gmail.com>
Subject: Re: Documentation suggestion on Netlink specs: missing fixed-header
 info
Message-ID: <avUvDvhSnp1c-q0E@fedora>
References: <8610ee11-e1dc-481a-9654-11188a06786a@jacobi.pw>
 <cff30946-5984-4d69-a590-3c7291d8f32c@infradead.org>
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
In-Reply-To: <cff30946-5984-4d69-a590-3c7291d8f32c@infradead.org>

Hi Randy,
On Wed, Nov 11, 2026 at 06:16:51PM -0800, Randy Dunlap wrote:
> Hi netdev:
> 
> Does anyone know what this means and what to do about it?
> Thanks.

Wessel noted that the `fixed-header` field appears in `rt-link.html` but is
missing from `rt-route.html`, even though the field is present in `rt-route.yaml`.

I think it is because we put it in the operations in rt-route.yaml.

  operations:
    enum-model: directional
    fixed-header: rtmsg
    name-prefix: rtm-
    list:

While in rt-link.yaml it's in the list field

  operations:
    enum-model: directional
    name-prefix: rtm-
    list:
      -
        name: newlink
        doc: Create a new link.
        attribute-set: link-attrs
        fixed-header: ifinfomsg

I will do a test and post the update if works.

Thanks
Hangbin

> 
> On 11/5/26 2:48 AM, Wessel Jacobi wrote:
> > Hello,
> > 
> > The "fixed-header" information is missing for the Netlink rt-route specification docs.
> > This is pretty essential information for working with Netlink, and I was tearing my hair out on why I couldn't find it.
> > 
> > Compare the (visible) `fixed-header` at [1] with the (absent) `fixed-header` information on [2]. The `fixed-header` key *is* present in the source yaml `Documentation/netlink/specs/rt-route.yaml` [3], but it seems it doesn't get reflected in the generated HTML version.
> > 
> > The HTML documentation would be more pleasant and useful if it had all the relevant information.
> > 
> > Thank you
> > 
> > [1]: https://www.kernel.org/doc/html/v7.4-rc1/netlink/specs/rt-link.html#operations
> > [2]: https://www.kernel.org/doc/html/v7.4-rc1/netlink/specs/rt-route.html#operations
> > [3]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/netlink/specs/rt-route.yaml?h=v7.4-rc1#n709
> > 
> 
> -- 
> ~Randy
