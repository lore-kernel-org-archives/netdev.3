Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F99330D40D
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 07:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790840166; cv=none; b=EnmZuh9LwkYbOLPALJKECs4vHHGvkqiwROyDZZEr33Oq/gcee9arTqtUwW1w7pg5/PCTh3HxMHghm8D4wcMkG2f9Jk8ZGrY9MjJy81co+/fQ53AKLRoIH7vBzuVejlwtnIooOik8W8EGfJqmt5JBfvO5mb39pRB+gobRhVXdAco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790840166; c=relaxed/simple;
	bh=PaaDyhPqimAK52iTpAw86CvffMIjxANW/bZ4t9wF0ZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W3NnFvBCfDB0t1RJi8kl6Tjjn+kx/+EPSqjK6JS6gLhbVSnLfXqEVaz7glkfSpU6tVtG+kGHiA0e14BIDtYEgVFFBEA+f9GjXlMfDMEBDr9Tmk37KFwnxs7Jtw88LgFbIxEIZSEwbHkm1loCth9GhxfJqIad9bCMVtYltxAmcAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=nUtsxFSO; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="nUtsxFSO"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2a1f611461so228286766b.1
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 00:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1790840162; x=1791444962; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v8creQGIzzLaelOSChMmnGW0N61aB5cBJPXK4wSK93s=;
        b=nUtsxFSOMMKqOctViGY838gn392CNwRRC1lJQZe1pFL47pCIkHY/XLSOT9Udo7jvfp
         hs3Xufxn0uN2M8aAzxotVoo6/sKQIUwnT/F6148UL2YhPUHRJTPLSNsCseTK1+NNY4Nz
         w0aDLPJdDpI4hodHsQc7hU5JQ12GM/Ej8Ffkzf9q4rSDX2HCNoU260ZJt+t53luAViAm
         3D6GKbcSLb83Y3QulFXAEHlbmNTXQcUJW/x98flXLNd0pNLKRm8CupeD5lQjpYpm0rAT
         R104RaMucg042Elfmz+pbxX89zXIoUxzbAyIBRWQletA8jliiX04mrb6U5dEGZTiF4Gw
         VhWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790840162; x=1791444962;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v8creQGIzzLaelOSChMmnGW0N61aB5cBJPXK4wSK93s=;
        b=fjRRCyOjECdOvi3YGrP8fqTUh+6Ph/WkuzUSoLIHtEn3/Tn/U7DhBQ+m1eUZjAiYl2
         rwaliTli3ZzjE33YGDEUR0wpZJ5uBK+aNaWFeBgqjCxT+OAmRtjtJqMruEivLCqUGe+w
         fiL4MdI7qDN/GLi3de38LcEKWRb7JxkJxEL4UXVsv8XqaVI5LY+yxohW61iNApOZ3eSw
         /9Aier1C2W8cds47x1QZqS+0kCb4kVfA+/mXJxM9XH6UTzV5jmeei/MIbJuGQaSVtzHf
         M70DtKKyjkqUfKNI232rQ50Pgo3p9KyZuKmNsSY+ymCNRDgLpvp84i3zNBRZSRtX3UZ1
         XWdA==
X-Gm-Message-State: AFuF++lFibvz37815SPQhBp21by2hl1Qxheg2H0SViH97c7fPQPpH8Mz
	lR333JWKPzW8ASN+nztyOYr2XtaEJjMzTyKCVh/MAD0CyhjD+wNimuEz4YebdvUxBZhWTF7qhk9
	fJ30y1oY=
X-Gm-Gg: AYBFou0nLPSQcRVJkAQjph2nzFnP2njoE5624IWI9EcEoGuW/8yPg0E1OpakivobBsl
	ucv0Ani4/pMOxaYiPAeg4XpFzeQuphzRQwXVlqhSKWAAFJifEU3bSjPk/BH8f+FCh9ZWrEx4Er/
	5AKns9AqXSr4j3tQJcm3u9JNqkwhcHdYOdbfkdL3hp8yGyXd2Fh8Q/UPijzx3XdzVHxFVmM87kt
	MMGlXPKbgfdP0y5LDWExwHz4Mkmt/nU9Erb1hnQuM3Mq7HG2HCk1Jkr0qsJFg6ceCHpZjzfIWo1
	zRI82sCz6CnLm2t36p8B9xu//JFU+L8En42+uwCH80k6B4J/kSrWGS0VWBK5ytt9Fo7nfE9bitW
	aNKdOOxZJ11ysJd0kjQEHSe7n4Cg6JvaxSziincwTmRkWjxS5GtFsneO9Lw0oXG+MFOz7iq10x7
	Aw1JfD1PiOHBl0EyQa1kNU72pa1x62ZsHXMG9P54d4hih/3nxvk5i/WUlR0B8oG7vPQctbP80DG
	x/n/cue3dvTxXU2bbnORQUb31iS
X-Received: by 2002:a17:907:8e0e:b0:c2d:ba74:b809 with SMTP id a640c23a62f3a-c2e33e02c9cmr189382666b.16.1790840162394;
        Thu, 01 Oct 2026 00:36:02 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e31c93c31sm98333366b.11.2026.10.01.00.36.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 00:36:01 -0700 (PDT)
Message-ID: <9a9701d4-c304-4565-9544-a8c4df96e4a8@blackwall.org>
Date: Thu, 1 Oct 2026 10:36:00 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 11/12] net: bridge: fdb: cache VLAN destinations
 in configured entries
Content-Language: en-US, bg
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bridge@lists.linux.dev
References: <20260930071411.2786201-1-razor@blackwall.org>
 <20260930071411.2786201-12-razor@blackwall.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260930071411.2786201-12-razor@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/09/2026 10:14, Nikolay Aleksandrov wrote:
> Use the known port-VLAN destination for user-configured fdb entries and
> resolve switchdev vids with an fdb helper. VLAN 0, bridge entries and
> unconfigured switchdev vids retain raw port destinations. Keep the vid
> alongside the destination because it remains part of the fdb key.
> Use conditional replacement for same port destination upgrades so they
> don't overwrite a concurrent packet-learned roam. Port changing updates
> remain direct and report a forwarding change.
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> ---
>   net/bridge/br_fdb.c | 61 +++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 50 insertions(+), 11 deletions(-)
> 
> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index 5664f3d649fa..730b178cf6c4 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -1192,10 +1192,11 @@ static bool fdb_handle_notify(struct net_bridge_fdb_entry *fdb, u8 notify)
>   }
>   
>   /* Update (create or replace) forwarding database entry */
> -static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
> +static int fdb_add_entry(struct net_bridge *br, struct net_bridge_dst dst,
>   			 const u8 *addr, struct ndmsg *ndm, u16 flags, u16 vid,
>   			 struct nlattr *nfea_tb[])
>   {
> +	struct net_bridge_port *source = br_dst_port(dst);
>   	bool is_sticky = !!(ndm->ndm_flags & NTF_STICKY);
>   	bool refresh = !nfea_tb[NFEA_DONT_REFRESH];
>   	struct net_bridge_fdb_entry *fdb;
> @@ -1230,19 +1231,26 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
>   		if (!(flags & NLM_F_CREATE))
>   			return -ENOENT;
>   
> -		fdb = fdb_create(br, br_port_to_dst(source), addr, vid,
> +		fdb = fdb_create(br, dst, addr, vid,
>   				 BIT(BR_FDB_ADDED_BY_USER));
>   		if (!fdb)
>   			return -ENOMEM;
>   
>   		modified = true;
>   	} else {
> +		struct net_bridge_dst old_dst;
> +
>   		if (flags & NLM_F_EXCL)
>   			return -EEXIST;
>   
> -		if (br_fdb_dst_port(fdb) != source) {
> -			br_fdb_dst_write(fdb, br_port_to_dst(source));
> -			modified = true;
> +		old_dst = br_fdb_dst_read(fdb);
> +		if (!br_dst_equal(old_dst, dst)) {
> +			if (br_dst_port(old_dst) != source) {
> +				modified = true;
> +				br_fdb_dst_write(fdb, dst);
> +			} else {
> +				br_fdb_dst_replace(fdb, old_dst, dst);
> +			}
>   		}
>   
>   		set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);

Sashiko says:
  If a concurrent packet learning roam occurs via __fdb_update() updating the
  destination locklessly, could br_fdb_dst_replace() fail here?
  If it fails, is it safe to ignore the failure and proceed to set
  BR_FDB_ADDED_BY_USER and potentially other authoritative flags like
  BR_FDB_STATIC below? It appears this might apply the flags to the concurrently
  roamed destination rather than the requested one, potentially corrupting
  hardware offload state and locking traffic to the wrong port.

  - Yes, it is safe and intentional behaviour, it must fail if a roam to a different port
    happened. The flags races are well-known and pre-existing behaviour.

> @@ -1296,6 +1304,7 @@ static int __br_fdb_add(struct ndmsg *ndm, struct net_bridge *br,
>   			bool *notified, struct netlink_ext_ack *extack)
>   {
>   	u16 vid = vlan ? vlan->vid : 0;
> +	struct net_bridge_dst dst;
>   	int err = 0;
>   
>   	if (ndm->ndm_flags & NTF_USE) {
> @@ -1320,8 +1329,10 @@ static int __br_fdb_add(struct ndmsg *ndm, struct net_bridge *br,
>   		}
>   		err = br_fdb_external_learn_add(br, p, addr, vid, false, true);
>   	} else {
> +		dst = p && vlan ? br_vlan_to_dst(vlan) : br_port_to_dst(p);
>   		spin_lock_bh(&br->hash_lock);
> -		err = fdb_add_entry(br, p, addr, ndm, nlh_flags, vid, nfea_tb);
> +		err = fdb_add_entry(br, dst, addr, ndm, nlh_flags, vid,
> +				    nfea_tb);
>   		spin_unlock_bh(&br->hash_lock);
>   	}
>   
> @@ -1553,10 +1564,31 @@ void br_fdb_unsync_static(struct net_bridge *br, struct net_bridge_port *p)
>   	rcu_read_unlock();
>   }
>   
> +static struct net_bridge_dst br_fdb_resolve_dst(const struct net_bridge_port *p,
> +						u16 vid)
> +{
> +	struct net_bridge_dst dst = br_port_to_dst(p);
> +	struct net_bridge_vlan *v;
> +
> +	lockdep_assert(rcu_read_lock_held() || lockdep_rtnl_is_held());
> +
> +	if (!p || !vid)
> +		return dst;
> +
> +	rcu_read_lock();
> +	v = br_vlan_find(nbp_vlan_group_rcu(p), vid);
> +	if (v)
> +		dst = br_vlan_to_dst(v);
> +	rcu_read_unlock();
> +
> +	return dst;
> +}
> +
>   int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
>   			      const unsigned char *addr, u16 vid, bool locked,
>   			      bool swdev_notify)
>   {
> +	struct net_bridge_dst dst = br_fdb_resolve_dst(p, vid);
>   	struct net_bridge_fdb_entry *fdb;
>   	bool modified = false;
>   	int err = 0;
> @@ -1581,25 +1613,32 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
>   		if (locked)
>   			flags |= BIT(BR_FDB_LOCKED);
>   
> -		fdb = fdb_create(br, br_port_to_dst(p), addr, vid, flags);
> +		fdb = fdb_create(br, dst, addr, vid, flags);
>   		if (!fdb) {
>   			err = -ENOMEM;
>   			goto err_unlock;
>   		}
>   		fdb_notify(br, fdb, RTM_NEWNEIGH, swdev_notify);
>   	} else {
> +		struct net_bridge_dst old_dst;
> +
> +		old_dst = br_fdb_dst_read(fdb);
>   		if (locked &&
>   		    (!test_bit(BR_FDB_LOCKED, &fdb->flags) ||
> -		     br_fdb_dst_port(fdb) != p)) {
> +		     br_dst_port(old_dst) != p)) {
>   			err = -EINVAL;
>   			goto err_unlock;
>   		}
>   
>   		WRITE_ONCE(fdb->updated, jiffies);
>   
> -		if (br_fdb_dst_port(fdb) != p) {
> -			br_fdb_dst_write(fdb, br_port_to_dst(p));
> -			modified = true;
> +		if (!br_dst_equal(old_dst, dst)) {
> +			if (br_dst_port(old_dst) != p) {
> +				modified = true;
> +				br_fdb_dst_write(fdb, dst);
> +			} else {
> +				br_fdb_dst_replace(fdb, old_dst, dst);
> +			}
>   		}
>   
>   		if (test_and_set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {

Sashiko says:
  Similarly, if br_fdb_dst_replace() fails here due to a concurrent destination
  update in __fdb_update(), could hardware learning flags like
  BR_FDB_ADDED_BY_EXT_LEARN be misapplied to the new roamed port?

  - Yes, again pre-existing and well-known behaviour. See my reply above.


