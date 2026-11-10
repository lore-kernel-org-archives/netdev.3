Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794307690;
	b=A77BD8hnn9p6IurAUXUA1ttL7gW7WLju/+XwfJXIsb75x1YH9NFEk9xDxvcAU+h0aBch
	 XgNCHLPYiDYQLkSnyotRpDjnC9xjXJtnkH5obJFJoAQRdgvYqjggbXTPyIyizCu4z8tHf
	 ZLVZ1zvPiwX4gB7nGNRUuM5WkRtRbeXybnIWbLvfTsyqcM48VgMi+EwqM0P2hw2fYH/kO
	 IjyoAMS2R59OQeArujg+OXGKJp31lZlCOP4VCCn6S8+3PB1JfmnzaNef4PmAz+OHu8Mts
	 rmvz6DmQEpvbUe9JxSYZixvygkIVQVTtimYnsGf5to6f2TUIzHlQuKSlYBVtUknmd0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794307690;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To;
	bh=AsVpshVWUcahAJco6yGQFmBOgaw87iAoLtHAaOYVCFs=;
	b=zyXqlS0IMyIZ4bDn6AEdqB2mttjbhSW32Ra58qxHcE9MUZLJNyb8jEy118kJxfuru3SQ
	 dk7AZmrITHJZBzFucJyxWDvDd2D1EfYSZEk7+Fy+LoYjNiO4r3dt5mvG4q7J0S9LH+2Ox
	 zNwQqHgU4lFJ/aXFXOYoOCq20skZMyFbU0FGGKQ2/IKm7TJx1tr8Po7WJQo8ts1WnKeWI
	 1pHO0bs9cm+lMMeZK3JfyN7vgs+7mpWm07TzQe7zXDlU7vaPMEjTqzpqz/bir6BODnZ+6
	 gcwwfHPQGJ1+jOh07ToxvBqN4rUnYHDVPTD367gSh2QtrywOnu3NU7EXGgN/ewt4Czg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=FJ+yNBRx;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946DE606A33F
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 10:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 946DE606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=FJ+yNBRx
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so12168295e9.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 02:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794307688; x=1794912488; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AsVpshVWUcahAJco6yGQFmBOgaw87iAoLtHAaOYVCFs=;
        b=FJ+yNBRxyJI2z7b9ifd1BlWgPyDujuP2bucSCxdd2jMCCs2Vq+y4Fg1q2qXXeVscn9
         EDBeZTKKPxc5cwKpQ1zbptmVdrVEaBhQbEPKjLOB8gDdBVuC6cmkvy9rE9ba1e+7Qkci
         DncEFa7RlS3gf5l8G33OgqHGfOasXBPTLKjqVLP19T4YyGzT5srN2n7zvsO9zQNUemSK
         yIFXayt+0HJrSNQa8igR1kJ6445w0Q7c89bEdbaBgIK2G0a1kkn8yPuiFaQBxYdMuVw3
         dRLQOPVCONqsVm+QcYaSrdtXPjVawC8Ehaf1Eu5PNMDhKdU6bbf5EdA+6oRIbTvo+WFR
         biHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794307688; x=1794912488;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AsVpshVWUcahAJco6yGQFmBOgaw87iAoLtHAaOYVCFs=;
        b=m5rkiszLqJTjBJ8k8vuftdke9ZqXqEXm2e4Gj22R5N15NY82xxjaeMBXXBw1MDNy9A
         lYUkNWg37tCulud96T02Rg1CNRgWbe3qRrnNujg68iRZtPPo9CEXd47FMSL3sW7dpQhM
         uTF68T4kZkDJv49GcZ8KOHJeQ6zTuSC32kj1F94MBojtKfZWwCY9gV+7M8V/V1H3s8sU
         HGSgycPumn+xD0vQdM7VjqEjksGlk1sGmtVOiX8IXJGUwUU3rMkWM68AKJIOvZA0I/yD
         hCYHbLL7kV3mpxTR00Yg8su8MH67SgPG+egRUUdq8FYz5JEJHtS7ojBfapWWXWG3IXZY
         EfoA==
X-Forwarded-Encrypted: i=1; AL+hErHZBl1+qq5FripmTUBzlIIy316OHjcMz6ecKZC0KHbgxvvNs5PfN63wrDtVXgyDtuaObC3s6iY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+JqQ8VrulwAuW7akqlyrnZdBBj84SONOv4EPLXcF29B7rfZ4GX
	mMW7LbYznvo0m5NogiLmTuDg7g5/5YOjP+S2M8W5e2oAfVqywQl0wSbXij9vlOmiTYE=
X-Gm-Gg: AYBFou11/6Dc39TtINysl7s+O4eYAeQQ5QhrvEeUUkZ6i5BPGLcOFYkMBE5ZL2tTZik
	rLPwqN1xu3CNkJIUKUVVhZq3gW8M5cn5BbUi3FRGBvwgDVqNtmIH8sZwrs8kUNVCrsgfwa1Evev
	d4otvEfR1O9m20+VBLeFMhCe0McoPsskG5X/MI+hTZVMocrAkGuGYCxDrptjGQJ50pBvS/sGJZQ
	K0sIEyho3Su6TdXCDm96wIAQh+cVIdUDmrG636K8nfrwItV0cz5rEapkRUjmInSnjDgE/cz9AD0
	V4L8X5K7lgg/YULr1OtyNiZaOe+SRdPWgVnht4W5Udi426eWulpTgS8Y6MA1u+rYBCqvaJjMdOU
	OcqJ8dyq6E8wQiWgJw9xzZJuwaI25kVRPZbePUoezasrU2VMGQjFyhnha35SroNI58nWTibncnF
	LYtoHwHLvrAwnYLTA741iafQRgTztl/RTISVzjq90gjZCnweDGaRkXCT4VVjgYJuXdy6wT9nWYt
	8FX3X7n7gsuMV3psA0v3keqs1+gL8DLXnvIVFH5/FEnEJMkFcpFeU7pBXvPiBgYIKPI6z/bUrT1
	1JJCtbyJMtG2QZy1rqNi69k6ePA6gJI3IshCi7+NS+HITd59Ww2beM2XUDHIcDbleqdslQuv
X-Received: by 2002:a05:600c:348d:b0:4a1:6992:f861 with SMTP id 5b1f17b1804b1-4ba023051a5mr35822815e9.1.1794307687833;
        Tue, 10 Nov 2026 02:48:07 -0800 (PST)
Received: from ?IPV6:2001:a61:1365:2501:d97e:4bec:d495:3c3f? ([2001:a61:1365:2501:d97e:4bec:d495:3c3f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0204ee67sm57409875e9.13.2026.11.10.02.48.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 02:48:07 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------lieuYdQrnBx6m16xWGNncEST"
Message-ID: <a26ce7f8-e2df-4d1b-a22f-1787126ca989@suse.com>
Date: Tue, 10 Nov 2026 11:48:04 +0100
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
Subject: Re: [PATCH net] net: usb: rtl8150: fix rx tasklet use-after-free on
 disconnect
To: Myeonghun Pak <mhun512@gmail.com>, Petko Manolov <petkan@nucleusys.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Ijae Kim <ae878000@gmail.com>
References: <20261110043016.56986-1-mhun512@gmail.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20261110043016.56986-1-mhun512@gmail.com>

This is a multi-part message in MIME format.
--------------lieuYdQrnBx6m16xWGNncEST
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.11.26 05:30, Myeonghun Pak wrote:

Hi,

> Kill the tasklet again after unlink_all_urbs() has waited for all
> completion handlers. tasklet_kill() drains any late tasklet and prevents
> self-rescheduling; disabled endpoints prevent it from leaving an RX
> URB in flight. Keep the first kill to stop an existing reschedule loop
> before unregister_netdev().
> 
> Found by a static analysis tool under development.

Good catch; nice tool.
But the fix is not correct.

> Fixes: eff674a514bd ("USB: rtl8150_disconnect() needs tasklet_kill()")
> Cc: stable@vger.kernel.org
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> 
> ---
> 
>   drivers/net/usb/rtl8150.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
> index d51e43170e03..98c36c377956 100644
> --- a/drivers/net/usb/rtl8150.c
> +++ b/drivers/net/usb/rtl8150.c
> @@ -971,6 +971,8 @@ static void rtl8150_disconnect(struct usb_interface *intf)
>   		tasklet_kill(&dev->tl);
>   		unregister_netdev(dev->netdev);
>   		unlink_all_urbs(dev);
> +		/* A completion may have scheduled it after the first kill. */
> +		tasklet_kill(&dev->tl);

The tasklet, however, can also submit the URB again, which in turn
can submit the tasklet and so on. There is an unavoidable window
in that sequence, as tasklet_kill() will kill the tasklet, but it may
have run in the window.

Hence you need to also, in addition to your patch, actually prevent the
resubmission of the URBs. The attached fix will do so.

How do we do this? Shall I submit? Do you want a joint submission?

	Regards
		Oliver

--------------lieuYdQrnBx6m16xWGNncEST
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-net-usb-rtl8150-break-cycle-between-tasklet-and-URB.patch"
Content-Disposition: attachment;
 filename*0="0001-net-usb-rtl8150-break-cycle-between-tasklet-and-URB.pat";
 filename*1="ch"
Content-Transfer-Encoding: base64

RnJvbSBjOGI4OGQ0NWNhZWYwYzJmZGZhMGIxYTUxZjc3YzJkYjU2NzY1OGJmIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBPbGl2ZXIgTmV1a3VtIDxvbmV1a3VtQHN1c2UuY29t
PgpEYXRlOiBUdWUsIDEwIE5vdiAyMDI2IDExOjI2OjM0ICswMTAwClN1YmplY3Q6IFtQQVRD
SF0gbmV0OiB1c2I6IHJ0bDgxNTA6IGJyZWFrIGN5Y2xlIGJldHdlZW4gdGFza2xldCBhbmQg
VVJCCgpUaGUgdGFza2xldCBjYW4gcmVzdWJtaXQgdGhlIFVSQiwgd2hpY2ggaW4gdHVybiBj
YW4KcmVzdWJtaXQgdGhlIHRhc2tsZXQuIFRoZSBjeWNsZSBuZWVkcyB0byBiZSBicm9rZW4K
dGhlIHNpbXBsZXN0IHdheSB0byBkbyBzbyBpcyB0byBwcmV2ZW50IHRoZSByZXN1Ym1pc3Np
b24Kb2YgdGhlIFVSQnMgYnkgcG9pc29uaW5nIHRoZW0uCgpTaWduZWQtb2ZmLWJ5OiBPbGl2
ZXIgTmV1a3VtIDxvbmV1a3VtQHN1c2UuY29tPgotLS0KIGRyaXZlcnMvbmV0L3VzYi9ydGw4
MTUwLmMgfCAxNiArKysrKysrKysrKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0
aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC91c2Iv
cnRsODE1MC5jIGIvZHJpdmVycy9uZXQvdXNiL3J0bDgxNTAuYwppbmRleCBkNTFlNDMxNzBl
MDMuLjYzNWU2NWEwZGU0MyAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvdXNiL3J0bDgxNTAu
YworKysgYi9kcml2ZXJzL25ldC91c2IvcnRsODE1MC5jCkBAIC0zNTMsMTEgKzM1MywxOCBA
QCBzdGF0aWMgdm9pZCBmcmVlX2FsbF91cmJzKHJ0bDgxNTBfdCAqIGRldikKIAl1c2JfZnJl
ZV91cmIoZGV2LT5pbnRyX3VyYik7CiB9CiAKK3N0YXRpYyB2b2lkIHJlZW5hYmxlX2FsbF91
cmJzKHJ0bDgxNTBfdCAqIGRldikKK3sKKwl1c2JfdW5wb2lzb25fdXJiKGRldi0+cnhfdXJi
KTsKKwl1c2JfdW5wb2lzb25fdXJiKGRldi0+dHhfdXJiKTsKKwl1c2JfdW5wb2lzb25fdXJi
KGRldi0+aW50cl91cmIpOworfQorCiBzdGF0aWMgdm9pZCB1bmxpbmtfYWxsX3VyYnMocnRs
ODE1MF90ICogZGV2KQogewotCXVzYl9raWxsX3VyYihkZXYtPnJ4X3VyYik7Ci0JdXNiX2tp
bGxfdXJiKGRldi0+dHhfdXJiKTsKLQl1c2Jfa2lsbF91cmIoZGV2LT5pbnRyX3VyYik7CisJ
dXNiX3BvaXNvbl91cmIoZGV2LT5yeF91cmIpOworCXVzYl9wb2lzb25fdXJiKGRldi0+dHhf
dXJiKTsKKwl1c2JfcG9pc29uX3VyYihkZXYtPmludHJfdXJiKTsKIH0KIAogc3RhdGljIGlu
bGluZSBzdHJ1Y3Qgc2tfYnVmZiAqcHVsbF9za2IocnRsODE1MF90ICpkZXYpCkBAIC01MTgs
NyArNTI1LDcgQEAgc3RhdGljIHZvaWQgaW50cl9jYWxsYmFjayhzdHJ1Y3QgdXJiICp1cmIp
CiAJcmVzID0gdXNiX3N1Ym1pdF91cmIgKHVyYiwgR0ZQX0FUT01JQyk7CiAJaWYgKHJlcyA9
PSAtRU5PREVWKQogCQluZXRpZl9kZXZpY2VfZGV0YWNoKGRldi0+bmV0ZGV2KTsKLQllbHNl
IGlmIChyZXMpCisJZWxzZSBpZiAocmVzICE9IC1FUEVSTSkKIAkJZGV2X2VycigmZGV2LT51
ZGV2LT5kZXYsCiAJCQkiY2FuJ3QgcmVzdWJtaXQgaW50ciwgJXMtJXMvaW5wdXQwLCBzdGF0
dXMgJWRcbiIsCiAJCQlkZXYtPnVkZXYtPmJ1cy0+YnVzX25hbWUsIGRldi0+dWRldi0+ZGV2
cGF0aCwgcmVzKTsKQEAgLTc1MSw2ICs3NTgsNyBAQCBzdGF0aWMgaW50IHJ0bDgxNTBfb3Bl
bihzdHJ1Y3QgbmV0X2RldmljZSAqbmV0ZGV2KQogCWlmICghZGV2LT5yeF9za2IpCiAJCXJl
dHVybiAtRU5PTUVNOwogCisJcmVlbmFibGVfYWxsX3VyYnMoZGV2KTsKIAlzZXRfcmVnaXN0
ZXJzKGRldiwgSURSLCA2LCBuZXRkZXYtPmRldl9hZGRyKTsKIAogCXVzYl9maWxsX2J1bGtf
dXJiKGRldi0+cnhfdXJiLCBkZXYtPnVkZXYsIHVzYl9yY3ZidWxrcGlwZShkZXYtPnVkZXYs
IDEpLAotLSAKMi41Ni4wCgo=

--------------lieuYdQrnBx6m16xWGNncEST--
