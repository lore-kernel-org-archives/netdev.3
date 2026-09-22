Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B155B3BB119
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 14:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790087801; cv=pass; b=m2GZfHVCVgV8OlSbXsZkLdpqM4B8k2wwPMKe2JtZNn+HMiuuYkkVQTn9eCwmkhACxCCCbVhamN0CJudDwUyHtUy+SXcdBKkp+txxbBNVN31a03ZkOF6cUjQfNgbChl37i1UHqfCpOQP24vGzm0oZmk/BIBdPZ+4TxLBrdeSvcys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790087801; c=relaxed/simple;
	bh=wm1mdUOdPY+A9xm9DAzxZQGN1bfMmm1ggAop9ZSmO7M=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BMuAjQ+Xqh7rgwMlH8pLrxeHyUTlx0wzZkjvane9ZeNVT/9hnp6r9JeUQ0cMFqYGV9vrUILnVCV9BNGQpPGKU/VQoNJv0uv1+h5z9J2nn3xthgNWSMGv/2JJ5gQOaiY8S7DYO/wahM1Vk6NejXLX3nLhcHe6Uj05gYAEaiDlGyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QNt1vtav; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mWoRVEOx; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QNt1vtav";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mWoRVEOx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790087798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Uhf7XUhU0j+LV6kdzlFblwsBGtqhh56gYh3J+aEB9A=;
	b=QNt1vtavmpZlABfNx2Yq+vtV9+MwkpO91vEQen/sKFxbaX2wpvUsVsQk6fh9ybKNqmrzoE
	8HvJ0MwJNe31c91CtAnHHMMFoPMKyREX2Futu6nCC4YyMZl/Pj3u4Ph+j34zxIm628lsqP
	5rms2YgHyPWZ7rUnLKEU6qRWQMY0w5k=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-XWRJkKhZOu6I_H3XefiHFQ-1; Tue, 22 Sep 2026 10:36:37 -0400
X-MC-Unique: XWRJkKhZOu6I_H3XefiHFQ-1
X-Mimecast-MFC-AGG-ID: XWRJkKhZOu6I_H3XefiHFQ_1790087797
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-67124ce8015so4928656d50.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 07:36:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790087797; cv=none;
        d=google.com; s=arc-20260327;
        b=hh6eOSANHJ4ddDk9WbnIQGMMNvCieHVPS8WownK3e12TJJGUVXz6IyQgmLQFBPLX0+
         GxO26bYi3MM8X6Rg85QP2gqLLwChzSdGdgrRBuIMAdZ1WORJD2L79y4gLWMhlABduHx8
         c6IsYxO+uN5NcIf4bPU+kj0eOc+AinXzoLup07GwjyAwHjXhLOAPGUBMfe2f72CD69z9
         MtsvDfI5A+RDqakQg1yu6fEV9BUEMViiyfzLF0CNXiLtF/+x36NJ38AlEzoIxtM2Bey4
         MSIY8TythWizxng91umgKGV6XO2qDRGz5xx7VJjnqvo0duQiRDQ8CUl7KkhsT90a0YuU
         ndgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:dkim-signature;
        bh=2Uhf7XUhU0j+LV6kdzlFblwsBGtqhh56gYh3J+aEB9A=;
        fh=MaoGU2LsHnondQW8T4sS+IPE5rFIWq8326yefueFIiA=;
        b=NinTlXcxmW8MpU9cXpNas4Fmc5b57PcJ10zWDQ6/T0hrOp9uSIip3vAUKojRAhGPs7
         UuZKujbJ+xzU+3At+/LFBdPqw/d+v3vbjiS3/Pt7p9vn6PpPhVUzfQK81TQhcF/gEVAq
         RwdNQPjQF5BY8i73snBd9a/CZJHYjVIDyz0NOIzBneAXqGecNY0l9eDIHOq/ABB7PNHx
         lxPeu3e/0Rvx7QaR2I1TH7pvKsvEagAeZ9L26UfV4Hl8huhB2bQCHtB+EcdHqRxODekG
         BjCMt1r+EFhBsQHXTNRZH7LDwxKr9Xiyd+pUaYgjQ0+Y+ytATVara0ElbdqyWAsv8F5j
         dDNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790087797; x=1790692597; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:in-reply-to:mime-version
         :references:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Uhf7XUhU0j+LV6kdzlFblwsBGtqhh56gYh3J+aEB9A=;
        b=mWoRVEOx4U2EC8oCpg3mslaEhgvUHKFWlNbI57ajkB/SJS/2rElKBUG+W8RhYh+5LC
         JTB/awgjTuvtI+CAXIDRGw0LS6Wpu/ENUNg1ndZGOcd9uCR454ddRp0mdRihXCl5TUnF
         f2g1XDeYSOP0pcEw26hC6ZTzhSGzhsfRtdSPoQV5SL6egPQE06ejo0yqqjnAjz42gVOk
         pLhKUNDzW9qNTXwT0M0i3ZwdgdbGw9A+sYETzrf7hAXXtJ/cRW7zGa8rhlMTvTt3l4JF
         9zFX/Sy6Am/5ZKoL8cMy3IDZiqR56rkwT1fzaKokiVQnam80jYGAGxrd3Sxy2Lyw/U04
         Jlbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790087797; x=1790692597;
        h=content-type:cc:to:subject:message-id:date:in-reply-to:mime-version
         :references:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Uhf7XUhU0j+LV6kdzlFblwsBGtqhh56gYh3J+aEB9A=;
        b=WVwsuWFFZrIAjjAMp7oQafSbdyfu4ojGpy6sw+t3bhkdJdDvamydMewlGq+d3hQi17
         Il+pS0+sXHSANhI9NveqOOLuOE0SCD+me9wH7GMqRkLFB5E5bP9Xbp8+7CMlbwWV5Mbx
         ZIchjwhA8zkVjuIV/qPjerMsn6JddN/XXDIX9pmxCrP0z56q0VIJau6vzKU0W0TYgmpy
         bhRJLUpjRCCc5gaSZhh/IPwoA0VCAsui78LMpdcRZnXVKT6cxmjpXd6/PsDRlDgv0/IH
         ezIHRNBcMZFyQ2AK+01jOdyGWKeV472jBTXRSSDJDfz+mFXUeKI+Zp4SdUUdcebW+1iv
         XWOw==
X-Forwarded-Encrypted: i=1; AKwUvByQ9dWN2h9h+0LpEWJeB3WoLcmzNdE1hz830KnB/A29fTKtCEXKXgnkkNrE8zxtRYv/3rERZTo=@vger.kernel.org
X-Gm-Message-State: AFuF++la5zkpw9G6KlUn2mhBhYzZLBZ2OJ1Slx95PFLq1uWsEsM56IYH
	f71qBEQBIvrXEndQFoaRdqnzs1SKNGHBcXTdDKlmal5hlF/dFwlLDlApDJMKaYcufUdTma9L+UI
	JkZQqWqeZ+kvsWULwy69rK6a5KZL2JRlyKipH5Uvc7DCJDS0mZ/VYW+28LgpzAAECKXlKDl07+L
	4dzc8dC/ey51zOQ0vdYm53ehpN7CyveeJc
X-Gm-Gg: AYBFou0CGHvaPdE+myJ9MJD7prOtSk2u3w4mhbySCJj6ewyKPol6nLUAZNzhewmOkOe
	QB2gec/ArTSS7ksPLY24u+h4NZh3DtM8p1d+iBjkxAMrkleq46WZRxuLWxPpZFPK+GzcN4KuPsY
	ikL95TndZB1dxpAVaejIWODUr4I7RZq5msZJJW25LZ1qGhua+yKDkUNZ0=
X-Received: by 2002:a05:690e:168a:b0:672:c55b:6bec with SMTP id 956f58d0204a3-672c55b76b1mr1249995d50.5.1790087796398;
        Tue, 22 Sep 2026 07:36:36 -0700 (PDT)
X-Received: by 2002:a05:690e:168a:b0:672:c55b:6bec with SMTP id
 956f58d0204a3-672c55b76b1mr1249970d50.5.1790087795940; Tue, 22 Sep 2026
 07:36:35 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Sep 2026 10:36:32 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Sep 2026 10:36:32 -0400
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20260921101538.97286-6-johannes@sipsolutions.net>
 <20260921101538.97286-9-johannes@sipsolutions.net> <98b93c98-21ae-4248-a60a-9625a20508ad@kernel.org>
 <7f557f5a-b21e-45cc-9d3a-cd4f8b5f799b@ovn.org> <99e5f7c0d7debc8a59bac96e93f09600bf488ca8.camel@sipsolutions.net>
 <4a0240a7b9ff87302620a95c73f4f265cd428618.camel@sipsolutions.net> <dca799b4-23f5-4b6f-be73-bad5a3d88007@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <dca799b4-23f5-4b6f-be73-bad5a3d88007@ovn.org>
Date: Tue, 22 Sep 2026 10:36:32 -0400
X-Gm-Features: AclHuK_WQy-H4M9Vjbwisdq6E74XDMCt0MUm8uA9loRbh4lJmNGD-_684UY2a9A
Message-ID: <CAG=2xmOuz6JEqZROE26nHEq5MgwTBNU_PvSqw1sn1MzAohotWg@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] net: dropreason: use new __print_sym() in tracing
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, Matthieu Baerts <matttbe@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Aaron Conole <aconole@redhat.com>, 
	Eelco Chaudron <echaudro@redhat.com>, dev@openvswitch.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Antoine Tenart <atenart@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 22, 2026 at 11:01:10AM +0200, Ilya Maximets wrote:
> On 9/22/26 1:20 AM, Johannes Berg wrote:
> > On Tue, 2026-09-22 at 00:36 +0200, Johannes Berg wrote:
> >>
> >> Indeed. Something like this (untested right now, didn't manage to spin
> >> up a test yet):
> >>
> >> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> >> index a31f7fb6882d..9b8edfcd2d1a 100755
> >> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
> >> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> >> @@ -234,7 +234,7 @@ ovs_drop_reason_count()
> >>  	local reason=$1
> >>
> >>  	local perf_output=`perf script -i ${ovs_dir}/perf.data -F trace:event,trace`
> >> -	local pattern="skb:kfree_skb:.*reason: $reason"
> >> +	local pattern="skb:kfree_skb:.*reason: $reason$"
> >>
> >>  	return `echo "$perf_output" | grep "$pattern" | wc -l`
> >>  }
> >> @@ -790,15 +790,6 @@ test_psample() {
> >>  # - drop packets and verify the right drop reason is reported
> >>  test_drop_reason() {
> >>  	which perf >/dev/null 2>&1 || return $ksft_skip
> >> -	which pahole >/dev/null 2>&1 || return $ksft_skip
> >> -
> >> -	ovs_drop_subsys=$(pahole -C skb_drop_reason_subsys |
> >> -			      awk '/OPENVSWITCH/ { print $3; }' |
> >> -			      tr -d ,)
> >> -	if [ -z "$ovs_drop_subsys" ]; then
> >> -		info "failed to get OVS drop subsys ID"
> >> -		return $ksft_skip
> >> -	fi
> >>
> >>  	sbx_add "test_drop_reason" || return $?
> >>
> >> @@ -842,7 +833,7 @@ test_drop_reason() {
> >>  		"in_port(2),eth(),eth_type(0x0800),ipv4(src=172.31.110.20,proto=1),icmp()" 'drop'
> >>
> >>  	ovs_drop_record_and_run "test_drop_reason" ip netns exec client ping -c 2 172.31.110.20
> >> -	ovs_drop_reason_count 0x${ovs_drop_subsys}0001 # OVS_DROP_FLOW_ACTION
> >> +	ovs_drop_reason_count OVS_DROP_LAST_ACTION
> >>  	if [[ "$?" -ne "2" ]]; then
> >>  		info "Did not detect expected drops: $?"
> >>  		return 1
> >> @@ -859,7 +850,7 @@ test_drop_reason() {
> >>
> >>  	ovs_drop_record_and_run \
> >>              "test_drop_reason" ip netns exec client nc -i 1 -zuv 172.31.110.20 6000
> >> -	ovs_drop_reason_count 0x${ovs_drop_subsys}0004 # OVS_DROP_EXPLICIT_ACTION_ERROR
> >> +	ovs_drop_reason_count OVS_DROP_EXPLICIT_WITH_ERROR
> >>  	if [[ "$?" -ne "1" ]]; then
> >>  		info "Did not detect expected explicit error drops: $?"
> >>  		return 1
> >> @@ -867,7 +858,7 @@ test_drop_reason() {
> >>
> >>  	ovs_drop_record_and_run \
> >>              "test_drop_reason" ip netns exec client nc -i 1 -zuv 172.31.110.20 7000
> >> -	ovs_drop_reason_count 0x${ovs_drop_subsys}0003 # OVS_DROP_EXPLICIT_ACTION
> >> +	ovs_drop_reason_count OVS_DROP_EXPLICIT
> >>  	if [[ "$?" -ne "1" ]]; then
> >>  		info "Did not detect expected explicit drops: $?"
> >>  		return 1
> >>
> >
> > No longer untested, that works.
>
> Looks nicer than parsing obscure numbers indeed!

+1, way prettier indeed.

>
> Matthieu mentioned we'll need CONFIG_TRACEPOINTS in the selftest config
> shard: tools/testing/selftests/net/openvswitch/config
>
> Is that a new dependency or was it always there we just missed adding it
> to the config before?  (it's included in the common net config, so that
> is probably the reason why CI doesn't fail)
>
> Best regards, Ilya Maximets.
>

