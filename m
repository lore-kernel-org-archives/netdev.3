Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CC9125A0;
	Fri, 23 Jan 2026 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769175686; cv=none; b=KnwsdwPvkr2UKHSIb5VG35O8v0vbSWUeU/6xB+qzZ3oksa6fJYjJinj0RA7Ne0+uHKnBybYP+9JKpmSNFZXgVGgZKubAYJClchjfsMbXWyTx36iGJZPaiglZctro/thfQvkwCkKBf05Wm+kc0VTkSHlaBIMJ14z/zNyhGQrg2zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769175686; c=relaxed/simple;
	bh=do2e/CSIHF5dJkRLghwIqSlg6dKkQmZn5pQERA5U68o=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UrYqF4OyN24e6kKXJZK3JbYkYiGA8PMVx62uY7sgZlTNFs2RWQ2PJgoWrNWxSkOo8JtB8FebS/rcA5OcVB8BUG9Qi2HV3Kmixz2sArG1VnGNxlQZVQEx0DHm0xDyaisXjzV4NHDv4Qf5EPwztPqPYMe9yNZC/Ax50iZ5SICylAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=dS9nd8+m; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="dS9nd8+m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1769175684; x=1800711684;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=do2e/CSIHF5dJkRLghwIqSlg6dKkQmZn5pQERA5U68o=;
  b=dS9nd8+mXbt8gOxItsLS0uwj/et2Oqko8bnB4TaO6QzJV/cC0N7CQuxO
   1V5EeURWieFebIZr9QjYE0YRwh44/u0COX7kSeNK44LTXZkZgzB2bam5B
   UTIwBD2mjCqFGwYjdNflTypq3ulFBxh7xl79W0bIz1cf6mBLm/miPREpX
   O87vd3g+cOsMlIuwLvlImHF2Klkzh+CgS9s5ED4rZn1XtMYelIP2EgoRB
   Sm6Nksdqnori2UpSUP2C61tPxrjUORbHI1WRn5gpJ/OwpJ9BIZqkkYmYg
   MORQrJF8aSxYvvGvBx3Pkl3zzIe2QBgGT7npj4lon3IRYi97Cpm+itN/O
   w==;
X-CSE-ConnectionGUID: O2McOyaWS0ulriGmBsOphg==
X-CSE-MsgGUID: ZVHzzlkjSp6ax6VX1TTYlA==
X-IronPort-AV: E=Sophos;i="6.21,248,1763449200"; 
   d="scan'208";a="219642505"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2026 06:41:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 23 Jan 2026 06:40:48 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 23 Jan 2026 06:40:46 -0700
Message-ID: <e401c44526f7b618fb18acf65c599828c9d5efbe.camel@microchip.com>
Subject: Re: [PATCH net-next] net: phy: micrel: Add support for lan9645x
 internal phy
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
	<andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Horatiu Vultur <horatiu.vultur@microchip.com>,
	<o.rempel@pengutronix.de>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date: Fri, 23 Jan 2026 14:40:46 +0100
In-Reply-To: <d5177d67-7b61-4459-befe-999dc052ca2b@bootlin.com>
References: <20260123-phy_micrel_add_support_for_lan9645x_internal_phy-v1-1-8484b1a5a7fd@microchip.com>
	 <d5177d67-7b61-4459-befe-999dc052ca2b@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgTWF4aW1lLAoKT24gRnJpLCAyMDI2LTAxLTIzIGF0IDA5OjU3ICswMTAwLCBNYXhpbWUgQ2hl
dmFsbGllciB3cm90ZToKPiAKPiBIaSBKZW5zLAo+IAo+IE9uIDIzLzAxLzIwMjYgMDg6NTAsIEpl
bnMgRW1pbCBTY2h1bHogw5hzdGVyZ2FhcmQgd3JvdGU6Cj4gPiBMQU45NjQ1WCBpcyBhIGZhbWls
eSBvZiBzd2l0Y2ggY2hpcHMgd2l0aCA1IGludGVybmFsIGNvcHBlciBwaHlzLgo+ID4gVGhlCj4g
PiBpbnRlcm5hbCBQSFkgaXMgYmFzZWQgb24gcGFydHMgb2YgTEFOODgzMi4gVGhpcyBpcyBhIGxv
dy1wb3dlciwKPiA+IHNpbmdsZQo+ID4gcG9ydCB0cmlwbGUtc3BlZWQgKDEwQkFTRS1ULzEwMEJB
U0UtVFgvMTAwMEJBU0UtVCkgZXRoZXJuZXQKPiA+IHBoeXNpY2FsCj4gPiBsYXllciB0cmFuc2Nl
aXZlciAoUEhZKSB0aGF0IHN1cHBvcnRzIHRyYW5zbWlzc2lvbiBhbmQgcmVjZXB0aW9uIG9mCj4g
PiBkYXRhCj4gPiBvbiBzdGFuZGFyZCBDQVQtNSwgYXMgd2VsbCBhcyBDQVQtNWUgYW5kIENBVC02
IFVuc2hpZWxkZWQgVHdpc3RlZAo+ID4gUGFpciAoVVRQKSBjYWJsZXMuCj4gPiAKPiA+IEFkZCBz
dXBwb3J0IGZvciB0aGUgaW50ZXJuYWwgUEhZIG9mIHRoZSBsYW45NjQ1eCBjaGlwIGZhbWlseS4K
PiA+IAo+ID4gUmV2aWV3ZWQtYnk6IFN0ZWVuIEhlZ2VsdW5kIDxTdGVlbi5IZWdlbHVuZEBtaWNy
b2NoaXAuY29tPgo+ID4gUmV2aWV3ZWQtYnk6IERhbmllbCBNYWNob24gPGRhbmllbC5tYWNob25A
bWljcm9jaGlwLmNvbT4KPiA+IFNpZ25lZC1vZmYtYnk6IEplbnMgRW1pbCBTY2h1bHogw5hzdGVy
Z2FhcmQKPiA+IDxqZW5zZW1pbC5zY2h1bHpvc3RlcmdhYXJkQG1pY3JvY2hpcC5jb20+Cj4gPiAt
LS0KPiAKPiBbLi4uXQo+IAo+ID4gK3N0YXRpYyBpbnQgbGFuOTY0NXhfY29uZmlnX2ludHIoc3Ry
dWN0IHBoeV9kZXZpY2UgKnBoeWRldikKPiA+ICt7Cj4gPiArwqDCoMKgwqAgaW50IGVycjsKPiA+
ICsKPiA+ICvCoMKgwqDCoCAvKiBlbmFibGUgLyBkaXNhYmxlIGludGVycnVwdHMgKi8KPiA+ICvC
oMKgwqDCoCBpZiAocGh5ZGV2LT5pbnRlcnJ1cHRzID09IFBIWV9JTlRFUlJVUFRfRU5BQkxFRCkg
ewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBUaGlzIGlzIGFuIGludGVybmFsIFBI
WSBvZiBsYW45NjQ1eCBhbmQgaXMgbm90Cj4gPiBwb3NzaWJsZSB0bwo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICogY2hhbmdlIHRoZSBwb2xhcml0eSBvZiBpcnEgc291cmNlcyBpbiB0
aGUgT0lDCj4gPiAoQ1BVX0lOVFIpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBm
b3VuZCBpbiBsYW45NjQ1eC4gVGhlcmVmb3JlIGNoYW5nZSB0aGUgcG9sYXJpdHkKPiA+IG9mIHRo
ZQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogaW50ZXJydXB0IGluIHRoZSBQSFkg
ZnJvbSBiZWluZyBhY3RpdmUgbG93IGluc3RlYWQKPiA+IG9mIGFjdGl2ZQo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICogaGlnaC4KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAqLwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwaHlfd3JpdGUocGh5ZGV2LCBMQU44
ODA0X0NPTlRST0wsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgTEFOODgwNF9DT05UUk9MX0lOVFJfUE9MQVJJVFkpOwo+ID4gKwo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAvKiBCeSBkZWZhdWx0IGludGVycnVwdCBidWZmZXIgaXMgb3Blbi1k
cmFpbiBpbiB3aGljaAo+ID4gY2FzZSB0aGUKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAqIGludGVycnVwdCBjYW4gYmUgYWN0aXZlIG9ubHkgbG93LiBUaGVyZWZvcmUgY2hhbmdlCj4g
PiB0aGUKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGludGVycnVwdCBidWZmZXIg
dG8gYmUgcHVzaC1wdWxsIHRvIGJlIGFibGUgdG8KPiA+IGNoYW5nZQo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICogaW50ZXJydXB0IHBvbGFyaXR5Lgo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICovCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBoeV93cml0ZShw
aHlkZXYsIExBTjg4MDRfT1VUUFVUX0NPTlRST0wsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTEFOODgwNF9PVVRQVVRfQ09OVFJPTF9JTlRSX0JVRkZF
Uik7Cj4gCj4gU21hbGwgbml0IGZyb20gbWUsIHlvdSdyZSBtaXNzaW5nIGVycm9yIGNoZWNrcyBv
biB0aGUgMiBhYm92ZSByZWFkcy4KPiAKPiBUaGFua3MsCj4gCj4gTWF4aW1lCj4gCgpUaGFuayB5
b3UsIEkgd2lsbCBhZGQgZXJyb3IgY2hlY2tzIGluIHRoZSBuZXh0IHZlcnNpb24uCgpUaGFua3Ms
CgpFbWlsCg==

