Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0A2279907
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 09:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773136128; cv=none; b=T9oCpt4kj5qHo5Dm7+Ky07pHJXFqv5kHy5C4eK5zW22AIYH7IWqfPos6gYuQP1EgOsFHbY4RbBpHvUp8Otwg+KrbSmti+H6aO4LjUKxbCte10l4KgKGj2MD9/AxjNQeLmh9KfF53EHw9ZTnocSKAjaMqkejE80z77yrObo0Zm2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773136128; c=relaxed/simple;
	bh=wRaF+sFOii+n7KacPrzsk/JdJa1rQAEvzCfGK1rpfCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fl8UwonHSuUfr7lzesUJoug8pDi/JVGMEY8y/s4Ikh+5Zd3+gBtsLBLvDYYzG4HSXHwWgxCaAf08v67AVioakzXz+4jT1J6Xiy/PCM7QpA9yZ8Z4uL112MUgai79/FyBvTJjWCQn6IYHFO4QA4ld+t2+4Pii8+Rd4JQmuzSTj2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vaISahGu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qMmUFgCQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vaISahGu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qMmUFgCQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vaISahGu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qMmUFgCQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vaISahGu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qMmUFgCQ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1382E5BCD0;
	Tue, 10 Mar 2026 09:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773136125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NFpmx52uAYjyghtySz5nZ8UvByShx22kSe2DD/MK3yQ=;
	b=vaISahGuGvLCoSzCqy5euaE58uFS+WX5GH1RKzibdbDpghMrBFCIC2kkHhaY/+JCiCiAMZ
	J8Rr7XeuMRLM7wntdcmaUp6vppSlxb7GLy/sNAUF9Fn3UTFEY/z+kfzoSQv6ps29gZNjUi
	jugy13PyF64tEbYv+fGOgp4QEM/1ss8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773136125;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NFpmx52uAYjyghtySz5nZ8UvByShx22kSe2DD/MK3yQ=;
	b=qMmUFgCQn0tPkc109hlb2T/0Qam5Iir+4Uduh61mey4SxAeCYYO3iQCnQUZKH/cvW6edJw
	70LAili5yl1WU1Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vaISahGu;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qMmUFgCQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773136125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NFpmx52uAYjyghtySz5nZ8UvByShx22kSe2DD/MK3yQ=;
	b=vaISahGuGvLCoSzCqy5euaE58uFS+WX5GH1RKzibdbDpghMrBFCIC2kkHhaY/+JCiCiAMZ
	J8Rr7XeuMRLM7wntdcmaUp6vppSlxb7GLy/sNAUF9Fn3UTFEY/z+kfzoSQv6ps29gZNjUi
	jugy13PyF64tEbYv+fGOgp4QEM/1ss8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773136125;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NFpmx52uAYjyghtySz5nZ8UvByShx22kSe2DD/MK3yQ=;
	b=qMmUFgCQn0tPkc109hlb2T/0Qam5Iir+4Uduh61mey4SxAeCYYO3iQCnQUZKH/cvW6edJw
	70LAili5yl1WU1Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70B573F3BD;
	Tue, 10 Mar 2026 09:48:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PLhwGPzor2m8ZwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 10 Mar 2026 09:48:44 +0000
Message-ID: <e3cfb1a8-5b51-4ed5-8736-f435f4144443@suse.de>
Date: Tue, 10 Mar 2026 10:48:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ipsec v2] xfrm: iptfs: fix skb_put() panic on non-linear
 skb during reassembly
To: Antony Antony <antony@phenome.org>
Cc: netdev@vger.kernel.org, chopps@labn.net, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, herbert@gondor.apana.org.au,
 steffen.klassert@secunet.com, Hao Long <me@imlonghao.com>
References: <20260304140935.19783-1-fmancera@suse.de>
 <aa8FQEdKU9lNnGDv@Antony2201.local>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <aa8FQEdKU9lNnGDv@Antony2201.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,crash_vm2.sh:url,crash_vm1.sh:url];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1382E5BCD0

On 3/9/26 6:37 PM, Antony Antony wrote:
> On Wed, Mar 04, 2026 at 03:09:35PM +0100, Fernando Fernandez Mancera wrote:
>> In iptfs_reassem_cont(), IP-TFS attempts to append data to the new inner
>> packet 'newskb' that is being reassembled. First a zero-copy approach is
>> tried if it succeeds then newskb becomes non-linear.
>>
>> When a subsequent fragment in the same datagram does not meet the
>> fast-path conditions, a memory copy is performed. It calls skb_put() to
>> append the data and as newskb is non-linear it triggers
>> SKB_LINEAR_ASSERT check.
> 
> I wonder if linearizing has a performance penalty? Did you test that?
> 

What do you mean? As this is the slowpath and the zero-copy mechanism 
cannot be used, it has a performance penalty. What alternative do we 
have here?

> I tried to reproduce it but had no luck so far. It seems the NICs I tested,
> CX4 and virtio, veth, deliver the inner packet as a linear skb.
> 
> Any tricks to force Mellanox CX4 and virtio to deliver
> non-linear skbs?
> 

So I didn't try Mellanox but let me share my reproducer script. I have 
VM 1 with IP 192.168.124.49 and VM 2 with IP 192.168.124.134. Both using 
virtio.

Then I use the following scripts to configure IPTFS with strongswang and 
I configure ipsec0 on VM2 mtu to 9000, finally I run `ping -s 3333 
10.0.1.2` from VM 2 to VM 1.

This at least on my system triggers the problem immediately.

Thanks,
Fernando.

---
$ cat crash_vm1.sh
#!/bin/bash
# Setup script for VM 1 (192.168.124.49)

PEER_IP="192.168.124.134"
LOCAL_TUN_IP="10.0.1.1"
REMOTE_TUN_IP="10.0.1.2"
IF_ID="42"

systemctl stop firewalld || true

MAIN_IF=$(ip route get $PEER_IP | awk '{for(i=1;i<=NF;i++) if($i=="dev") 
print $(i+1)}')

ip link del ipsec0 2>/dev/null || true
ip link add name ipsec0 type xfrm dev $MAIN_IF if_id $IF_ID
ip link set ipsec0 up
ip addr add $LOCAL_TUN_IP/24 dev ipsec0

mkdir -p /etc/strongswan/swanctl
mkdir -p /etc/swanctl

cat <<EOF > /etc/strongswan/swanctl/swanctl.conf
connections {
     aggfrag_tunnel {
         local_addrs  = 192.168.124.49
         remote_addrs = 192.168.124.134
         version = 2
         proposals = aes256-sha256-modp2048

         local {
             auth = psk
             id = vm1
         }
         remote {
             auth = psk
             id = vm2
         }

         children {
             aggfrag_child {
                 local_ts  = $LOCAL_TUN_IP/32
                 remote_ts = $REMOTE_TUN_IP/32
                 mode = iptfs
                 start_action = start
                 esp_proposals = aes256gcm128
                 if_id_in = $IF_ID
                 if_id_out = $IF_ID
             }
         }
     }
}

secrets {
     ike-psk {
         id-vm1 = vm1
         id-vm2 = vm2
         secret = "super-secret-psk-for-reproduction"
     }
}
EOF

ln -sf /etc/strongswan/swanctl/swanctl.conf /etc/swanctl/swanctl.conf

systemctl enable --now strongswan
systemctl restart strongswan
sleep 2
swanctl --load-all

ip route add $REMOTE_TUN_IP/32 dev ipsec0 2>/dev/null || true

---
$ cat crash_vm2.sh
#!/bin/bash
# Setup script for VM 2 (192.168.124.134)

PEER_IP="192.168.124.49"
LOCAL_TUN_IP="10.0.1.2"
REMOTE_TUN_IP="10.0.1.1"
IF_ID="42"

systemctl stop firewalld || true

MAIN_IF=$(ip route get $PEER_IP | awk '{for(i=1;i<=NF;i++) if($i=="dev") 
print $(i+1)}')

ip link del ipsec0 2>/dev/null || true

ip link add name ipsec0 type xfrm dev $MAIN_IF if_id $IF_ID
ip link set ipsec0 up
ip addr add $LOCAL_TUN_IP/24 dev ipsec0

mkdir -p /etc/strongswan/swanctl
mkdir -p /etc/swanctl

cat <<EOF > /etc/strongswan/swanctl/swanctl.conf
connections {
     aggfrag_tunnel {
         local_addrs  = 192.168.124.134
         remote_addrs = 192.168.124.49
         version = 2
         proposals = aes256-sha256-modp2048

         local {
             auth = psk
             id = vm2
         }
         remote {
             auth = psk
             id = vm1
         }

         children {
             aggfrag_child {
                 local_ts  = $LOCAL_TUN_IP/32
                 remote_ts = $REMOTE_TUN_IP/32
                 mode = iptfs
                 esp_proposals = aes256gcm128
                 if_id_in = $IF_ID
                 if_id_out = $IF_ID
             }
         }
     }
}

secrets {
     ike-psk {
         id-vm1 = vm1
         id-vm2 = vm2
         secret = "super-secret-psk-for-reproduction"
     }
}
EOF

ln -sf /etc/strongswan/swanctl/swanctl.conf /etc/swanctl/swanctl.conf

systemctl enable --now strongswan
systemctl restart strongswan
sleep 2
swanctl --load-all

ip route add $REMOTE_TUN_IP/32 dev ipsec0 2>/dev/null || true


