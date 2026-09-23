Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF9D2E4257
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 12:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790166707; cv=none; b=oOvM17/u2fsVuJ+Wxqrss79ATzHXytuBVkEM2BTOnJRha56SlaadN5fwE4ZQjcfzpYHn1i8RKIvr76dvoQhVa2WhRNa0+Q6gpiuZ2oCzAQ/ovTAHRl8esdX2pbyvw7KrzGBLHaz/tJAKo9yqTvFaYvdVpapit6iTFDhfTBCrUcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790166707; c=relaxed/simple;
	bh=8x/UT7yNCTBqE0gUbAyrfvJfTd1tBx2IpOQcX0TQguA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=klMUUCVbGX+JACGwM3YB3W83tnlk+13a/DqlazqEn0WO5YSD0knQkCQLiATe+aDQ39WxiuJIeZNvjrq7j49Ui0WerkIoHbQYhq1wya152cuCkrFpX2ue1g5eWPUAYFvFrzzmtUA3w+DWlJNA4cpUFRXGLW/SWZgKHv74DDfFDAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gwsAs6pN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RVyOaM+h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gwsAs6pN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RVyOaM+h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790166701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iy4LAVksYVGANuIsEoVI9Hlhk9VjhocmxupJMIEdc3A=;
	b=gwsAs6pNgS8Tryvd2zk2VQ5eTz6AbrD2W5asFlXKCx6OVohQxSE1ybgYPeKrtnzX+xwLff
	NcdyoBRIPn9Q7PmzVZl+6vQuXlFbezfn77j3SzLpSrwHYymP1WJwxuZ/kW1c7mq4/qjXcm
	SEg777onIbgrjrXCDfRhrWPoEfzsToI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-QJxUWFoQMLmxDFs6QOgfAg-1; Wed, 23 Sep 2026 08:31:39 -0400
X-MC-Unique: QJxUWFoQMLmxDFs6QOgfAg-1
X-Mimecast-MFC-AGG-ID: QJxUWFoQMLmxDFs6QOgfAg_1790166698
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-486f768517dso653065f8f.1
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 05:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790166698; x=1790771498; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:date:references:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Iy4LAVksYVGANuIsEoVI9Hlhk9VjhocmxupJMIEdc3A=;
        b=RVyOaM+hHkkxMtdSDUTlvIcqSRbP8VJd9t40tpLvQr3x8F0mdPfZrLGdEndzerxfH6
         9lIp0ceZ6eqReanDU9glSJJfGR8cNHFqe/UMdyzeEuTJK7W0fvzxWpTKzqV4/k2cNYaD
         PuGyMY1BAimtvFccR2BMGSQGBX7ZH/zs+LdkDY6QcFQh7D4dMvTBjjDTcvLXtesyqC0C
         hWUdm/YcIQx2+ysELCvLrzvBRg3xAIHVZOpF1+8GWJNhNkpSz08G7ftfltfjdj5ORmVB
         ZlBjJnHzmjOaKA+K/DRY0j67WtFlZGtP2EvvYxF4ASt1v1I/Kndc4GfLN5YtRyz7snsF
         j/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790166698; x=1790771498;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:date:references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Iy4LAVksYVGANuIsEoVI9Hlhk9VjhocmxupJMIEdc3A=;
        b=cXldMi6DlTEsYJWKvVbIHpCJvlzhvCmY9SqMdKBBt39NardauxeZ2G9OHutnynws78
         MYF6ehoWbaAtrG25A2F82LAPM0NqpS+1MX0xjiiQYJQ0wLfFakwfnbU1YxQXnfGOQBEm
         mmMGD5YvOw/Bb3cM4V1kLy4fnSEDJ8MjIKwUDHkRZJsd5aB1s7fTFo7zNCKm4hNoRIuR
         tc8oa+YXlx9WIOCVpz8UyKNS8vvFDDxdIqPzCMv2Iv+eIAHNKANaViTpztbRHBM8kAId
         wP3yra2AvrURpWMo7QvtKvblPn8zVbWuvz5K/TaP5cCSqK00B1IY7vNpyU0QvEnuKSAv
         eg6Q==
X-Forwarded-Encrypted: i=1; AKwUvBylasI6bOfL12882+9McxL51OKKxT/OMVHH7GRQ6UH1lfKOIMLhahqkKCNwR45i+3RtzWfwbQo=@vger.kernel.org
X-Gm-Message-State: AFuF++nTLHLymfRTylXElFD1jpVHZ/b8BQ1j+R8rhZfSwWDFZOIHXxFG
	NQ19RRD2kUa0ZCUjZ70WSkqtDgOwfDB9cfLTc+szSIXXpvs1A1vZ+8x4P2RwdAc2iIiqXdD838f
	Y7CaYb4vFHXfS+mHQfGknhRlk9DnOLwiXJ0+TNGYYDF3CSpyxYsdvqDd6gg==
X-Gm-Gg: AYBFou3MPtgloN8upfg9ZL0E7R1AHMFHmQGT1hOIGJQE/mrYbU72MhCH/8ShG73xkd6
	ub6YIxkyKvr5/ESVGX+jDzw+i2J/hRo0d541s9DyUM33p25Qa2Hq+q7a3Pj3lf4Nhv3H7O4Hwvt
	kUOJakgyHL/C6+zmw6rqkbZSMob+vXmWxikcyNgu/3KvYY23GXFbd7QPIYJCu6t6+qvJsw48lAu
	sGqhw7ok878+BEQ1WhHuFnnXhjwtQaACemrSnRcv+cXBS12KBoenvUp/mg+PdhOj5uJDwAGCx3V
	xhPkZ+ul2HWZB/541xZkT7U/+BjYIKRFMYPzP8yB+PaFClVxjIr0AFqgvcUml+TKLCNYN5WOEr3
	wPnoYiJKf44HcvrcpmYGPxyQww8NH
X-Received: by 2002:a05:6000:4023:b0:487:10b5:a88a with SMTP id ffacd0b85a97d-4886705fb90mr4236753f8f.9.1790166696249;
        Wed, 23 Sep 2026 05:31:36 -0700 (PDT)
X-Received: by 2002:a05:6000:4023:b0:487:10b5:a88a with SMTP id ffacd0b85a97d-4886705fb90mr4236704f8f.9.1790166695767;
        Wed, 23 Sep 2026 05:31:35 -0700 (PDT)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([216.212.25.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886877a19bsm7197338f8f.25.2026.09.23.05.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 05:31:34 -0700 (PDT)
From: Aaron Conole <aconole@redhat.com>
To: netdev-bot+sashiko@kernel.org
Cc: houminxi@gmail.com,  netdev@vger.kernel.org,  echaudro@redhat.com,
  i.maximets@ovn.org,  davem@davemloft.net,  edumazet@google.com,
  kuba@kernel.org,  pabeni@redhat.com,  horms@kernel.org,
  shuah@kernel.org,  dev@openvswitch.org,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/2] selftests/net/openvswitch: add SCTP
 flow key test over IPv6
In-Reply-To: <179008950943.2160803.15856491533624064435@kernel.org>
	(netdev-bot's message of "Tue, 22 Sep 2026 15:05:09 +0000")
References: <20260918144647.2024095-2-houminxi@gmail.com>
	<179008950943.2160803.15856491533624064435@kernel.org>
Date: Wed, 23 Sep 2026 08:31:31 -0400
Message-ID: <f7tpky49mjg.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

netdev-bot+sashiko@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [Medium] The promised skip when IPv6 is unavailable is incomplete in
>   test_sctp_connect_v6().
>
> --
>
> selftests/net/openvswitch: add SCTP flow key test over IPv6
>
> This adds test_sctp_connect_v6 to the openvswitch selftest, mirroring the
> existing IPv4 SCTP test: icmpv6() flows forward neighbour discovery while
> ipv6(proto=3D132),sctp(dst=3D4443)/sctp(src=3D4443) flows gate an SCTP
> association across the datapath, with a keyless ipv6(proto=3D132) install
> expected to be refused with EINVAL.
>
>> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh
>> b/tools/testing/selftests/net/openvswitch/openvswitch.sh
>> index a31f7fb6882d..aa84fafc3201 100755
>> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
>> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
>
> [ ... ]
>
>> @@ -700,6 +701,114 @@ test_sctp_connect_v4() {
>>  	return 0
>>  }
>>=20=20
>> +# sctp_connect_v6 test
>> +# - sctp(dst=3D4443) matches client-to-server INIT
>> +# - sctp(src=3D4443) matches server-to-client INIT-ACK
>> +# - icmpv6 NS/NA flows forward neighbour discovery
>> +# - remove flows and verify connection fails, reinstall and recover
>> +test_sctp_connect_v6() {
>> +	local t=3D"test_sctp_connect_v6"
>> +	local v6=3D"eth_type(0x86dd),ipv6(proto=3D132)"
>> +	local payload=3D"SCTP6_DATA_OK"
>> +	local rxfile=3D"${ovs_base}/${t}/sctp-rx.txt"
>> +
>> +	modprobe -q sctp 2>/dev/null || return "$ksft_skip"
>> +	socat -V 2>&1 | grep -q "define WITH_SCTP" || return "$ksft_skip"
>> +	socat -V 2>&1 | grep -q "define WITH_IP6" || return "$ksft_skip"
>> +	[ -e /proc/sys/net/ipv6 ] || return "$ksft_skip"
>
> [Severity: Medium]
>
> Is this gate enough to cover the case the changelog describes as "IPv6 is
> unavailable"?  /proc/sys/net/ipv6 only tells us inet6_init() ran.  Only
> ipv6.disable=3D1 short-circuits it:

We don't do much to check that ipv6 is available.  The ICMPv6 test
doesn't do any additional safeguards.

> net/ipv6/af_inet6.c:inet6_init() {
> 	...
> 	if (disable_ipv6_mod) {
> 		pr_info("Loaded, but administratively disabled, reboot required to enab=
le\n");
> 		goto out;
> 	}
> 	...
> }
>
> With ipv6.disable_ipv6=3D1 instead, initialization completes and the sysc=
tl
> tree exists, so this check passes, but the module default is copied into
> every new netns:
>
> net/ipv6/addrconf.c:addrconf_init_net() {
> 	...
> 	/* these will be inherited by all namespaces */
> 	dflt->autoconf =3D ipv6_defaults.autoconf;
> 	dflt->disable_ipv6 =3D ipv6_defaults.disable_ipv6;
> 	...
> }
>
> so the veths created for the client and server namespaces come up with
> cnf.disable_ipv6 set, and address assignment is rejected:
>
> net/ipv6/addrconf.c:ipv6_add_addr() {
> 	...
> 	if (idev->cnf.disable_ipv6) {
> 		NL_SET_ERR_MSG_MOD(extack, "IPv6 is disabled on this device");
> 		err =3D -EACCES;
> 		goto out;
> 	}
> 	...
> }
>
> Would testing something that reflects usability, for example whether an
> address can actually be added in a test namespace, match the promised skip
> better?

We don't generally have a check for this.  Maybe it makes sense, but
that could be a separate cleanup if it really is needed.

>> +
>> +	sbx_add "$t" || return $?
>> +	ovs_add_dp "$t" sctp6 || return 1
>> +
>> +	info "create namespaces"
>> +	for ns in client server; do
>> +		ovs_add_netns_and_veths "$t" "sctp6" "$ns" \
>> +		    "${ns:0:1}0" "${ns:0:1}1" || return 1
>> +	done
>> +
>> +	ip netns exec client ip addr add fd00::1/64 dev c1 nodad
>> +	ip netns exec client ip link set c1 up
>> +	ip netns exec server ip addr add fd00::2/64 dev s1 nodad
>> +	ip netns exec server ip link set s1 up
>
> [Severity: Medium]
>
> These four setup commands in test_sctp_connect_v6() discard their exit
> status, unlike the surrounding calls which all use "|| return 1".  If the
> ip addr add calls fail with EACCES because disable_ipv6 was inherited by
> the new namespaces, does the test keep going with no IPv6 addresses
> configured and then report a failure at the association check below?
>
> Would checking these with "|| return $ksft_skip" (or at least
> "|| return 1" with an info message naming the failed step) make the
> outcome match the cause?

See above - same answer.

> [ ... ]
>
>> +	info "verify SCTP association with port-keyed flows"
>> +	ovs_sbx "$t" ip netns exec client \
>> +	    timeout 3 socat -u STDIN "SCTP6-CONNECT:[fd00::2]:4443" </dev/null=
 \
>> +	    || return 1
>
> [Severity: Medium]
>
> This is the point where an unusable IPv6 setup surfaces.  With
> ipv6.disable_ipv6=3D1 the connect cannot succeed, so run_test() reports F=
AIL,
> while the changelog says:
>
>     Skips when the sctp module is missing, socat lacks SCTP or IPv6
>     support, or IPv6 is unavailable
>
> Should this configuration end up as a skip rather than a failure, or shou=
ld
> the changelog be narrowed to say the skip only covers IPv6 not being
> initialized at all?

I don't think either is needed for this series.

